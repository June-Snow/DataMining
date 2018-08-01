function cnn_live_minimal()
% CNN_IMAGENET_MINIMAL   Minimalistic demonstration of how to run an ImageNet CNN model
% setup toolbox
run(fullfile(fileparts(mfilename('fullpath')), '../matlab/vl_setupnn.m')) ;

blk_sz = [32 32]
load('data\live-baseline\2014-12-07/net-epoch-24.mat') ;
L = length(net.layers);
net.layers{1,L}.type = 'softmax';


% obtain and preprocess an image
im = imread('peppers.png');
blocks = im2block(im, blk_sz, blk_sz(1));
sblocks = ones(size(blocks), 'like', blocks);
score = zeros(1, size(blocks,4));
for i = 1 : size(blocks, 4);
    im_ = single(blocks(:,:,:,i)) ; % note: 255 range
    im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
    im_ = im_ - net.normalization.averageImage ;
    
    % run the CNN
    res = vl_simplenn(net, im_) ;
    
    % show the classification result
    scores = squeeze(gather(res(end).x)) ;
    [bestScore, best] = max(scores) ;
    score(i) = best;
    % figure(1) ; clf ; imagesc(im_,'EraseMode','none',[-1 1]) ;
    % pause();
end

for i = 1 : 11
    for j = 1 : 15
        temp = uint8(repmat(score((i-1)*11+j), blk_sz));
        simage{i,j} = temp;
    end
end
figure(1);imshow(im);
figure(2);
colormap(hot)
simage = cell2mat(simage);
imagesc(simage);
