function [ VideoFeature ] = getVideoFeature(aviVideo, Mrow, Mcol,FrameLen,Tol,Thr,xNum,yNum)
%%
leafMap = AccuDiff( aviVideo, Mrow, Mcol,FrameLen,Tol);%����ǰFrameLen���ۻ�֡���������Ҷ��ӳ�����0~1
firstFrame = read(aviVideo, 1);
firstFrame = preProcess(firstFrame, Mrow, Mcol);
[meanRGB,ratio,hist,meanHSV,histHsv]  = ExtFeature( firstFrame,Tol );%��ȡ��֡��ɫ������rgb�ռ��hsv�ռ�
[pixPerc,areaPerc,meanLeafRGB] = ExtLeafFea( firstFrame,leafMap,Thr,xNum,yNum );%��ȡ��Ҷ���������
VideoFeature = [meanRGB,ratio,hist,meanHSV,histHsv,pixPerc,areaPerc,meanLeafRGB];%1-3;4-7;8-37;38-40;41-76;77;78;79-81
end


