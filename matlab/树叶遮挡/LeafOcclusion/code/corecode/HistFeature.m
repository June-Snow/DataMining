function [ hist ] = HistFeature( firstFrame )
%% 提取三通道直方图特征，每个通道划分为10组
%%
[rHist,~] = imhist(firstFrame(:,:,1),10);
[gHist,~] = imhist(firstFrame(:,:,2),10);
[bHist,~] = imhist(firstFrame(:,:,3),10);
hist = [rHist',gHist',bHist'];
end

