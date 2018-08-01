function testCifar()

opts.dataDir = fullfile('data','cifar') ;
opts.expDir = fullfile('D:\STUDY\[0] MachineLearning\ToolBox\matconvnet-1.0-beta9\examples\data\cifar-baseline\') ;
opts.imdbPath = fullfile(opts.expDir, 'imdb.mat');
% opts.imdbPath = fullfile('D:\STUDY\[0] ELF-ramework\ELF-ramework\ELF-ramework\msraimdb.mat');
opts.train.batchSize = 100 ;
opts.train.numEpochs = 20 ;
opts.train.continue = true ;
opts.train.useGpu = false ;
%为什么有3组learning rate
opts.train.learningRate = [0.001*ones(1, 12) 0.0001*ones(1,6) 0.00001] ;
opts.train.expDir = opts.expDir ;

% --------------------------------------------------------------------
%                                                         Prepare data
% --------------------------------------------------------------------

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getCifarImdb(opts) ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

feat = [];
for i = 1 : size(imdb.images.data, 4)
    feat{i} = {imdb.images.data(:,:,:,i)};
end
imdb.images.data = feat;


model = [];
layerRet = [];
errRecord = [];
rng(0);
trainInd = find(imdb.images.set == 1);
for epoch = 1 : 40
    randIdx = randperm(numel(trainInd));
    randTrainInd = trainInd(randIdx);
    
    randFeature = imdb.images.data;
    randLabel = imdb.images.labels;
    [randPred, speed, model, layerRet] = ELFCnnTrain(model, randFeature, randLabel, layerRet);
        
    [wholeErr, classErr] =  iCalcError(randLabel, randPred);
    errRecord = [errRecord, [wholeErr; classErr]];
    
    h = figure(201);
    iShow(h, errRecord, randLabel, randPred, {'1','2','3','4','5','6','7','8','9','10'});
end


% --------------------------------------------------------------------
function imdb = getCifarImdb(opts)
% --------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
unpackPath = fullfile(opts.dataDir, 'cifar-10-batches-mat');
files = [arrayfun(@(n) sprintf('data_batch_%d.mat', n), 1:5, 'UniformOutput', false) ...
  {'test_batch.mat'}];
files = cellfun(@(fn) fullfile(unpackPath, fn), files, 'UniformOutput', false);
file_set = uint8([ones(1, 5), 3]);

if any(cellfun(@(fn) ~exist(fn, 'file'), files))
  url = 'http://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz' ;
  fprintf('downloading %s\n', url) ;
  untar(url, opts.dataDir) ;
end

data = cell(1, numel(files));
labels = cell(1, numel(files));
sets = cell(1, numel(files));
for fi = 1:numel(files)
  fd = load(files{fi}) ;
  data{fi} = permute(reshape(fd.data',32,32,3,[]),[2 1 3 4]) ;
  labels{fi} = fd.labels' + 1; % Index from 1
  sets{fi} = repmat(file_set(fi), size(labels{fi}));
end

set = cat(2, sets{:});
data = single(cat(4, data{:}));
dataMean = mean(data(:,:,:,set == 1), 4);
data = bsxfun(@minus, data, dataMean);

clNames = load(fullfile(unpackPath, 'batches.meta.mat'));

imdb.images.data = data ;
imdb.images.data_mean = dataMean;
imdb.images.labels = single(cat(2, labels{:})) ;
imdb.images.set = set;
imdb.meta.sets = {'train', 'val', 'test'} ;
imdb.meta.classes = clNames.label_names;
