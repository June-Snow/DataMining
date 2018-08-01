function [ ratio ] = RatioFrature( firstFrame,Tol )
%% 计算四种偏移像素点各占的比例：偏红、偏绿、偏蓝、不偏移
%%
maxImg = max(firstFrame,[],3);
maxImg = cat(3,maxImg,maxImg,maxImg);
diff = maxImg - firstFrame;
%% 三通道均差不多，定义为不偏
label = (diff <= Tol);
sumLabel = sum(label,3);
noCastLabel = sumLabel==3;
noCastRatio = mean(noCastLabel(:));
%% 其余情况，偏向最大通道
%若两者差不多，一个偏小，则两个通道都会加1，表现为这四者可能相加大于1
rCastLabel = diff(:,:,1) == 0;
rCastLabel = rCastLabel.^(~noCastLabel);
rCastRatio = mean(rCastLabel(:));
gCastLabel = diff(:,:,2) == 0;
gCastLabel = gCastLabel.^(~noCastLabel);
gCastRatio = mean(gCastLabel(:));
bCastLabel = diff(:,:,3) == 0;
bCastLabel = bCastLabel.^(~noCastLabel);
bCastRatio = mean(bCastLabel(:));
%%
ratio = [rCastRatio,gCastRatio,bCastRatio,noCastRatio];
end

