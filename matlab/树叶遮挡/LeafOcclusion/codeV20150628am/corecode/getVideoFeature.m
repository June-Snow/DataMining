function [ VideoFeature ] = getVideoFeature(aviVideo, Mrow, Mcol,FrameLen,Tol,Thr,xNum,yNum)
%%
leafMap = AccuDiff( aviVideo, Mrow, Mcol,FrameLen,Tol);%计算前FrameLen的累积帧差，并返回绿叶区映射概率0~1
firstFrame = read(aviVideo, 1);
firstFrame = preProcess(firstFrame, Mrow, Mcol);
[meanRGB,ratio,hist,meanHSV,histHsv]  = ExtFeature( firstFrame,Tol );%提取首帧颜色特征，rgb空间和hsv空间
[pixPerc,areaPerc,meanLeafRGB] = ExtLeafFea( firstFrame,leafMap,Thr,xNum,yNum );%提取绿叶区域的特征
VideoFeature = [meanRGB,ratio,hist,meanHSV,histHsv,pixPerc,areaPerc,meanLeafRGB];%1-3;4-7;8-37;38-40;41-76;77;78;79-81
end


