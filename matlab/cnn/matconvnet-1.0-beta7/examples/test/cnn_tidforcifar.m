function cnn_tidforcifar(varargin)

run(fullfile(fileparts(mfilename('fullpath')), '../matlab/vl_setupnn.m'));

opts.dataDir = 'data/cifar';
opts.expDir = 'data/cifar-baseline' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.imdbPath = fullfile(opts.expDir, 'imdb.mat');
opts.lite = false ;
opts.numFetchThreads = 0 ;
opts.train.batchSize = 100 ;
opts.train.numEpochs = 2 ;
opts.train.continue = true ;
opts.train.useGpu = false ;
opts.train.learningRate = [0.001*ones(1, 12) 0.0001*ones(1,6) 0.00001] ;
opts.train.expDir = opts.expDir ;
opts.test_small = false;
opts = vl_argparse(opts, varargin) ;

% -------------------------------------------------------------------------
%                                                   Database initialization
% -------------------------------------------------------------------------

if exist(opts.imdbPath)
    imdb = load(opts.imdbPath) ;
else
    make_data_tid2013();
end

% -------------------------------------------------------------------------
%                                                    Network initialization
% -------------------------------------------------------------------------

net = initializeNetwork(opts) ;

% compute the average image
% averageImagePath = fullfile(opts.expDir, 'average.mat') ;
% if exist(averageImagePath)
%     load(averageImagePath, 'averageImage') ;
% else
%     train = find(imdb.images.set == 1) ;
%     bs = 256 ;
%     fn = getBatchWrapper(net.normalization, opts.numFetchThreads) ;
%     for t=1:bs:numel(train)
%         batch_time = tic ;
%         batch = train(t:min(t+bs-1, numel(train))) ;
%         fprintf('computing average image: processing batch starting with image %d ...', batch(1)) ;
%         temp = fn(imdb, batch) ;
%         im{t} = mean(temp, 4) ;
%         batch_time = toc(batch_time) ;
%         fprintf(' %.2f s (%.1f images/s)\n', batch_time, numel(batch)/ batch_time) ;
%     end
%     averageImage = mean(cat(4, im{:}),4) ;
%     save(averageImagePath, 'averageImage') ;
% end

% net.normalization.averageImage = averageImage ;
% clear averageImage im temp ;
imdb.images.data = bsxfun(@minus, imdb.images.data, mean(imdb.images.data,4)) ;

% -------------------------------------------------------------------------
%                                               Stochastic gradient descent
% -------------------------------------------------------------------------
net.normalization = 0;
fn = getBatchWrapper(net.normalization, opts.numFetchThreads) ;

if opts.test_small
    imdb.images.set(1:200) = 1;
    imdb.images.set(101:200) = 3;
    imdb.images.set(201:end) = 0;
end

[net, info] = cnn_train(net, imdb, fn, opts.train, ...
                        'val', find(imdb.images.set == 3),...
                        'conserveMemory', true) ;
save 'tid_net' net
% -------------------------------------------------------------------------
function fn = getBatchWrapper(opts, numThreads)
% -------------------------------------------------------------------------
fn = @(imdb,batch) getBatch(imdb,batch,opts,numThreads) ;

% -------------------------------------------------------------------------
function [im,labels] = getBatch(imdb, batch, opts, numThreads)
% -------------------------------------------------------------------------
% images = strcat([imdb.imageDir '/'], imdb.images.name(batch)) ;
% im = cnn_tid_get_batch(images, opts, ...     
%                             'augmentation', 'f25') ;
% labels = imdb.images.label(batch) ;
im = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;

% --------------------------------------------------------------------
function imdb = getCifarImdb(opts)
% --------------------------------------------------------------------
unpackPath = fullfile(opts.dataDir, 'cifar-10-batches-mat');
files = [arrayfun(@(n) sprintf('data_batch_%d.mat', n), 1:5, 'UniformOutput', false) ...
    {'test_batch.mat'}];
files = cellfun(@(fn) fullfile(unpackPath, fn), files, 'UniformOutput', false);
file_set = uint8([ones(1, 5), 3]);

data = cell(1, numel(files));
labels = cell(1, numel(files));
sets = cell(1, numel(files));
for fi = 1:numel(files)
    fd = load(files{fi}) ;
    data{fi} = permute(reshape(fd.data',32,32,3,[]),[2 1 3 4]) ;
    labels{fi} = fd.labels' + 1; % Index from 1
    sets{fi} = repmat(file_set(fi), size(labels{fi}));
end

data = single(cat(4, data{:}));
dataMean = mean(data, 4);
data = bsxfun(@minus, data, dataMean);

clNames = load(fullfile(unpackPath, 'batches.meta.mat'));

imdb.images.data = data ;
imdb.images.data_mean = dataMean;
imdb.images.labels = single(cat(2, labels{:})) ;
imdb.images.set = cat(2, sets{:});
imdb.meta.sets = {'train', 'val', 'test'} ;
imdb.meta.classes = clNames.label_names;

% -------------------------------------------------------------------------
function net = initializeNetwork(opt)
% -------------------------------------------------------------------------


% Define network CIFAR10-quick
net.layers = {} ;

% 1 conv1
net.layers{end+1} = struct('type', 'conv', ...
    'filters', 1e-4*randn(5,5,3,32, 'single'), ...
    'biases', zeros(1, 32, 'single'), ...
    'filtersLearningRate', 1, ...
    'biasesLearningRate', 2, ...
    'stride', 1, ...
    'pad', 2) ;

% 2 pool1 (max pool)
net.layers{end+1} = struct('type', 'pool', ...
    'method', 'max', ...
    'pool', [3 3], ...
    'stride', 2, ...
    'pad', [0 1 0 1]) ;

% 3 relu1
net.layers{end+1} = struct('type', 'relu') ;

% 4 conv2
net.layers{end+1} = struct('type', 'conv', ...
    'filters', 0.01*randn(5,5,32,32, 'single'),...
    'biases', zeros(1,32,'single'), ...
    'filtersLearningRate', 1, ...
    'biasesLearningRate', 2, ...
    'stride', 1, ...
    'pad', 2) ;

% 5 relu2
net.layers{end+1} = struct('type', 'relu') ;

% 6 pool2 (avg pool)
net.layers{end+1} = struct('type', 'pool', ...
    'method', 'avg', ...
    'pool', [3 3], ...
    'stride', 2, ...
    'pad', [0 1 0 1]) ; % Emulate caffe

% 7 conv3
net.layers{end+1} = struct('type', 'conv', ...
    'filters', 0.01*randn(5,5,32,64, 'single'),...
    'biases', zeros(1,64,'single'), ...
    'filtersLearningRate', 1, ...
    'biasesLearningRate', 2, ...
    'stride', 1, ...
    'pad', 2) ;

% 8 relu3
net.layers{end+1} = struct('type', 'relu') ;

% 9 pool3 (avg pool)
net.layers{end+1} = struct('type', 'pool', ...
    'method', 'avg', ...
    'pool', [3 3], ...
    'stride', 2, ...
    'pad', [0 1 0 1]) ; % Emulate caffe

% 10 ip1
net.layers{end+1} = struct('type', 'conv', ...
    'filters', 0.1*randn(4,4,64,64, 'single'),...
    'biases', zeros(1,64,'single'), ...
    'filtersLearningRate', 1, ...
    'biasesLearningRate', 2, ...
    'stride', 1, ...
    'pad', 0) ;

% 11 ip2
net.layers{end+1} = struct('type', 'conv', ...
    'filters', 0.1*randn(1,1,64,10, 'single'),...
    'biases', zeros(1,10,'single'), ...
    'filtersLearningRate', 1, ...
    'biasesLearningRate', 2, ...
    'stride', 1, ...
    'pad', 0) ;
% 12 loss
net.layers{end+1} = struct('type', 'softmaxloss') ;

% Other details
% net.normalization.imageSize = [32, 32, 3] ;
% net.normalization.interpolation = 'bicubic' ;
% net.normalization.border = 256 - net.normalization.imageSize(1:2) ;
% net.normalization.averageImage = [] ;
% net.normalization.keepAspect = true ;