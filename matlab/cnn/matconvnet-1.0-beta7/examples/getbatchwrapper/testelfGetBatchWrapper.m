%% test_elfGetBatchWrapper
clc;
clear all;

imdb = load(fullfile('.\data\tid-baseline','imdb.mat'));

opts.imageSize = [64, 64, 3] ;
opts.interpolation = 'bicubic' ;
opts.border = 256 - opts.imageSize(1:2) ;
opts.averageImage = [] ;
opts.batchsize = 256;

train = find(imdb.images.set == 1) ;
bs = opts.batchsize;
fn = elfGetBatchWrapper(opts) ;
for t=1:bs:numel(train)
    batch_time = tic ;
    batch = train(t:min(t+bs-1, numel(train))) ;
    fprintf('computing average image: processing batch starting with image %d ...', batch(1)) ;
    [images labels] = fn(imdb, batch) ;
    batch_time = toc(batch_time) ;
    fprintf(' %.2f s (%.1f images/s)\n', batch_time, numel(batch)/ batch_time) ;
end