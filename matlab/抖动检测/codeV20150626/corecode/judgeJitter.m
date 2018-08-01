function [ VideoInf ] = judgeJitter( ImgInf,Thr )
%% 根据图像的信息（抖动判断、方向、偏移量、当前帧、参考帧）判断视频抖动参数(抖动判断、方向、频率、振幅)
%% 处理方向，以便计算抖动规律
ImgInf(:,2) = dirFilter(ImgInf(:,2));%对当前方向滤波
basicDir = direGroup(ImgInf); %计算基准方向
ImgInf = direLable( basicDir,ImgInf ); %参照基准方向，将当前方向分为两个组
%%


end

