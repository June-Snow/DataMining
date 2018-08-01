function [ meanRGB,ratio,hist,meanHSV,histHsv ] = ExtFeature( firstFrame,Tol)
%% 提取首帧特征:RGB三通道颜色均值、四种偏移像素点各占的比例、RGB三通道直方图统计、HSV三通道均值、HSV非均匀量化直方图
%% 提取首帧颜色特征,RGB空间：RGB三通道颜色均值、四种偏移像素点各占的比例、RGB三通道直方图统计
R = firstFrame(:,:,1);
G = firstFrame(:,:,2);
B = firstFrame(:,:,3);
meanRGB = [mean(R(:)),mean(G(:)),mean(B(:))];
ratio = RatioFrature( firstFrame,Tol );
hist = HistFeature( firstFrame );
%% 提取首帧颜色特征,HSV空间：HSV三通道均值、HSV非均匀量化直方图
HSVImg = rgb2hsv(firstFrame);
H = HSVImg(:,:,1);
S = HSVImg(:,:,2);
V = HSVImg(:,:,3);
meanHSV = [mean(H(:)),mean(S(:)),mean(V(:))];
histHsv = HistHsvFea(HSVImg);
end

