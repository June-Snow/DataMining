function [ hist ] = HistFeature( firstFrame )
%% ��ȡ��ͨ��ֱ��ͼ������ÿ��ͨ������Ϊ10��
%%
[rHist,~] = imhist(firstFrame(:,:,1),10);
[gHist,~] = imhist(firstFrame(:,:,2),10);
[bHist,~] = imhist(firstFrame(:,:,3),10);
hist = [rHist',gHist',bHist'];
end

