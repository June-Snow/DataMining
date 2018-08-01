function cnn_cifar_minimal()

% setup toolbox
run(fullfile(fileparts(mfilename('fullpath')), '../matlab/vl_setupnn.m')) ;

% download a pre-trained CNN from the web
net_path = './cifar_net_vgg.mat';
if ~exist(net_path)
  return;
end
net = load(net_path) ;

% obtain and preprocess an image
im = imread('peppers.png');
im_ = single(im) ; % note: 255 range
mean_size = size(net.normalization.averageImage);
im_ = imresize(im_, mean_size(1:2));
im_ = im_ - net.normalization.averageImage;
% run the CNN
res = vl_simplenn(net, im_);

% show the classification result
scores = squeeze(gather(res(end).x)) ;
[bestScore, best] = max(scores) ;
figure(1) ; clf ; imagesc(im) ;
title(sprintf('%s (%d), score %.3f',...
   net.classes{best}, best, bestScore)) ;

