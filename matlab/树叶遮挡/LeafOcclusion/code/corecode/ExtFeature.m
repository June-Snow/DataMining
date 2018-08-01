function [ meanRGB,ratio,hist,meanHSV,histHsv ] = ExtFeature( firstFrame,Tol)
%% ��ȡ��֡����:RGB��ͨ����ɫ��ֵ������ƫ�����ص��ռ�ı�����RGB��ͨ��ֱ��ͼͳ�ơ�HSV��ͨ����ֵ��HSV�Ǿ�������ֱ��ͼ
%% ��ȡ��֡��ɫ����,RGB�ռ䣺RGB��ͨ����ɫ��ֵ������ƫ�����ص��ռ�ı�����RGB��ͨ��ֱ��ͼͳ��
R = firstFrame(:,:,1);
G = firstFrame(:,:,2);
B = firstFrame(:,:,3);
meanRGB = [mean(R(:)),mean(G(:)),mean(B(:))];
ratio = RatioFrature( firstFrame,Tol );
hist = HistFeature( firstFrame );
%% ��ȡ��֡��ɫ����,HSV�ռ䣺HSV��ͨ����ֵ��HSV�Ǿ�������ֱ��ͼ
HSVImg = rgb2hsv(firstFrame);
H = HSVImg(:,:,1);
S = HSVImg(:,:,2);
V = HSVImg(:,:,3);
meanHSV = [mean(H(:)),mean(S(:)),mean(V(:))];
histHsv = HistHsvFea(HSVImg);
end

