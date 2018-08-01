function cnn_tid_minimal()
% CNN_IMAGENET_MINIMAL   Minimalistic demonstration of how to run an ImageNet CNN model
% setup toolbox
run(fullfile(fileparts(mfilename('fullpath')), '../matlab/vl_setupnn.m')) ;

blk_sz = [32 32]
% net.normalization.imageSize = [64, 64, 3] ;
% net.normalization.interpolation = 'bicubic' ;
% net.normalization.border = 256 - net.normalization.imageSize(1:2) ;
% net.normalization.keepAspect = true ;
load('tid_net.mat') ;
L = length(net.layers);
net.layers{1,L}.type='softmax'


% obtain and preprocess an image
im = imread('peppers.png');
blocks = im2block(im, blk_sz, blk_sz(1));
for i = 1 : size(blocks, 4);
    im_ = single(blocks(:,:,:,i)) ; % note: 255 range
    %im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
    %im_ = im_ - net.normalization.averageImage ;

% run the CNN
res = vl_simplenn(net, im_) ;

% show the classification result
scores = squeeze(gather(res(end).x)) ;
[bestScore, best] = max(scores) ;
figure(1) ; clf ; imagesc(im) ;
title(sprintf('%s (%d), score %.3f',...
   net.classes.description{best}, best, bestScore)) ;

pause();
end