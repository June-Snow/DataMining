function [ VideoInf ] = judgeJitter( ImgInf,Thr )
%% 根据位移判断抖动
ImgFlag = ImgInf(:,1);
proFlag = mean(ImgFlag);  % 所取的帧中被判断为抖动的概率
if proFlag > Thr
    VideoInf = 1;
else
    VideoInf = 0;
end

end

