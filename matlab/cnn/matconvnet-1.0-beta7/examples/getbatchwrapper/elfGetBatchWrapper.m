% fn = getBatchWrapper(net.normalization, opts.numFetchThreads) ;
% 
% [net,info] = cnn_train(net, imdb, fn, opts.train, 'conserveMemory', true) ;
%
% You can use it like this :
%     opts.imageSize = [64, 64, 3] ;
%     opts.interpolation = 'bicubic' ;
%     opts.border = 256 - opt.imageSize(1:2) ;
%     opts.averageImage = [] ;
%     opts.batchsize = 256;
%  
%     train = find(imdb.images.set == 1) ;
%     bs = opts.batchsize;
%     fn = elfGetBatchWrapper(opts) ;
%     for t=1:bs:numel(train)
%         batch_time = tic ;
%         batch = train(t:min(t+bs-1, numel(train))) ;
%         fprintf('computing average image: processing batch starting with image %d ...', batch(1)) ;
%         [images labels] = fn(imdb, batch) ;
%         batch_time = toc(batch_time) ;
%         fprintf(' %.2f s (%.1f images/s)\n', batch_time, numel(batch)/ batch_time) ;
%     end

% -------------------------------------------------------------------------
function fn = elfGetBatchWrapper(opts)
% -------------------------------------------------------------------------
fn = @(imdb,batch) getBatch(imdb,batch,opts) ;

% -------------------------------------------------------------------------
function [im,scores, ids] = getBatch(imdb, batch, opts)
% -------------------------------------------------------------------------
images = strcat([imdb.imageDir '/'], imdb.images.name(batch)) ;
im = cnn_tid_get_batch(images, opts, ...                            
                            'augmentation', 'f25') ;
scores = imdb.images.scores(batch) ;
ids = imdb.images.id(batch);


function imo = cnn_tid_get_batch(images, varargin)
% CNN_IMAGENET_GET_BATCH  Load, preprocess, and pack images for CNN evaluation

opts.imageSize = [28, 28] ;
opts.border = [0, 0] ;
opts.averageImage = [] ;
opts.augmentation = 'none' ;
opts.interpolation = 'bilinear' ;
opts.numAugments = 1 ;
opts = vl_argparse(opts, varargin);

% fetch is true if images is a list of filenames (instead of
% a cell array of images)
fetch = numel(images) > 1 && ischar(images{1}) ;

switch opts.augmentation
  case 'none'
    tfs = [.5 ; .5 ; 0 ];
  case 'f5'
    tfs = [...
      .5 0 0 1 1 .5 0 0 1 1 ;
      .5 0 1 0 1 .5 0 1 0 1 ;
       0 0 0 0 0  1 1 1 1 1] ;
  case 'f25'
    [tx,ty] = meshgrid(linspace(0,1,5)) ;
    tfs = [tx(:)' ; ty(:)' ; zeros(1,numel(tx))] ;
    tfs_ = tfs ;
    tfs_(3,:) = 1 ;
    tfs = [tfs,tfs_] ;
end

im = cell(1, numel(images)) ;

imo = zeros(opts.imageSize(1), opts.imageSize(2), 3, ...
            numel(images)*opts.numAugments, 'single') ;

[~,augmentations] = sort(rand(size(tfs,2), numel(images)), 1) ;

si = 1 ;
for i=1:numel(images)

  % acquire image
  if isempty(im{i})
    images{i}(images{i}=='\') = '/';
    imt = imread(images{i}) ;
    imt = single(imt) ; % faster than im2single (and multiplies by 255)
  else
    imt = im{i} ;
  end
  if size(imt,3) == 1
    imt = cat(3, imt, imt, imt) ;
  end

  % resize
  w = size(imt,2) ;
  h = size(imt,1) ;

  imo(:,:,:,si) = imt(:,:,:) ;
  si = si + 1 ;

end

if ~isempty(opts.averageImage)
  imo = bsxfun(@minus, imo, opts.averageImage) ;
end
