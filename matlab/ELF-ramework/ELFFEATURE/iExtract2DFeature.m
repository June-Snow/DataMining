function [ fout ] = iExtract2DFeature(featName, rawPath, mode)

%%
global DEBUG
methodResize = 'resize';
methodCrop = 'cropcenter';
methodHsv= 'hsv';
methodUlbp = 'ulbp';
methodEdge = 'edge';
methodOPFlow = 'opticalflow';
methodTexture = 'texture';
methodHSVQuantization = 'hsvquantization';
methodLocalContrast = 'localcontrast';

if nargin == 1
    if featName == 1
        fout = {methodResize, methodCrop, methodHsv, methodUlbp, methodEdge, methodOPFlow, methodLocalContrast};
    end
    if featName == 2
        fout = {methodResize, methodHsv, methodUlbp, methodEdge, methodTexture, methodHSVQuantization};
    end
    
    return;
end

%% Prepare
i = 1;
feat = [];
SZ = 170;
img = olReadDataToImg(rawPath);
% img = olCropTopBot(img, 0.2, 0.2); 
% img = rgb2gray(img);
if strcmp(mode, 'test') == 1
    [M, N, ~] = size(img);
    SZ = min(M, N);
end

while(i <= length(featName))
    switch(featName{i})
        case methodResize
            img = imresize(img, [SZ SZ]);
            f_ =  single(img)/255;

        case methodCrop
            img = olCropCenter(img, SZ);
            f_ = single(img)/255;

        case methodHsv
            hsv = rgb2hsv(img);
            f_ = hsv;
        case methodUlbp
            ulbpMap = iULBPFeat(img);
            f_ = ulbpMap;
        case methodEdge
            level = graythresh(img);
            BW = im2bw(img, level);
            f_ = BW;
        case methodOPFlow
            if  olIsVideoPath(rawPath)
                aviVideo = VideoReader(rawPath);        % 读取.avi格式视频文件
                frameLen = aviVideo.NumberOfFrames;
                uv = op(aviVideo, 1, min(20, frameLen-1), SZ);
                f_ = uv;
            else
                f_ = [];
                warning('Input is not video');
            end       
            
        case methodTexture
            f_ = TextureFeature(img);

        case methodHSVQuantization
            hsv = HSVQuantization(img);
            f_ = hsv;
            
        case methodLocalContrast
            f_ = imresize(img, [SZ SZ]);
            sigma1 = 4;
            sigma2 = 4;
            f_ = olLocalNormalize( f_, sigma1, sigma2 );
            f_ = f_ / (max(f_(:))-min(f_(:)));            
            
        otherwise
    end
    feat = cat(3, feat, f_);
    f_ = [];
    i  = i + 1;
end

fout = feat;

if DEBUG
%     figure(905);
%     imshow(BW);
end

end


%%
function uv = op(aviVideo, startF, endF, SZ)
frameLen = aviVideo.NumberOfFrames;
preImg = read(aviVideo, max(min(startF, frameLen-1),1));
preImg = olCropCenter(preImg, SZ);
curImg = read(aviVideo, max(min(endF, frameLen-1),1));
curImg = olCropCenter(curImg, SZ);
YCBCRpre = rgb2ycbcr(preImg);
YCBCRcur = rgb2ycbcr(curImg);
uv = opticalflow_main(YCBCRpre(:,:,2:3), YCBCRcur(:,:,2:3));
end

%% HSV颜色空间非均匀量化法
function hsv = HSVQuantization(img)

im = rgb2hsv(img);
h = im(:, :, 1);
s = im(:, :, 2);
v = im(:, :, 3);
% h
h(h>0.9166 | h<=0.0611) = 1;
h(h>0.0611 & h<=0.125) = 2;
h(h>0.125 & h<=0.1944) = 3;
h(h>0.1944 & h<=0.4305) = 4;
h(h>0.4305 & h<=0.5166) = 5;
h(h>0.5166 & h<=0.7722) = 6;
h(h>0.7722 & h<=0.9166) = 7;
% s
s(s>0.2 & s<=0.65) = 0;
s(s>0.65 & s<=1) = 1;
% v
v(v>=0.2 & v<=0.7) = 0;%与参考文献不同之处
v(v>0.7 & v<=1) = 1;
hsv(:,:,1) = h;
hsv(:,:,2) = s;
hsv(:,:,3) = v;
end

%纹理特征
function tex = TextureFeature(img)

tex = calculateFilterBanks_old(img);

%tex = ColorTextureFeature(img);
end

function tex = ColorTextureFeature(img)

% grayimg=rgb2gray(img);
% [L,a,b] = rgb2lab(img);
% img = im2double(L);

im = rgb2hsv(img);
tex1 = spatialgabor(im(:, :, 1),3,90,0.5,0.5,1);
tex2 = spatialgabor(im(:, :, 2),3,90,0.5,0.5,1);
tex3 = spatialgabor(im(:, :, 3),3,90,0.5,0.5,1);
tex = cat(3, tex1, tex2, tex3);

end



