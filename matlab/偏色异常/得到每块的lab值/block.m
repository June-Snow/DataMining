
%%

m = 4;
n = 4;
M = 288;
N = 352;

I = imread('F:\视频测试\视频帧\0000 正常视频\3_0865.bmp');
I = imresize(I, [M N]);

% blkX = fix(M / m);
% blkY = fix(N / n);
% for i = 1:m
%     for j = 1:n
%         xStart = 1    + (i-1)*blkX;
%         xEnd   = blkX + (i-1)*blkX;
%         yStart = 1    + (j-1)*blkY;
%         yEnd   = blkY + (j-1)*blkY;
%         subC = I(xStart:xEnd, yStart:yEnd, :);
%         I2 = getChroma(subC);
%         
%     end
% end

r = fix(M/m);
c = fix(N/n);
fun = @(block_struct)getChroma(block_struct.data);
I2 = blockproc(I, [r c], fun);


% figure;
% imshow(I);
% figure;
% save block I2
