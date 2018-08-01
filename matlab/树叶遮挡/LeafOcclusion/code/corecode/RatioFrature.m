function [ ratio ] = RatioFrature( firstFrame,Tol )
%% ��������ƫ�����ص��ռ�ı�����ƫ�졢ƫ�̡�ƫ������ƫ��
%%
maxImg = max(firstFrame,[],3);
maxImg = cat(3,maxImg,maxImg,maxImg);
diff = maxImg - firstFrame;
%% ��ͨ������࣬����Ϊ��ƫ
label = (diff <= Tol);
sumLabel = sum(label,3);
noCastLabel = sumLabel==3;
noCastRatio = mean(noCastLabel(:));
%% ���������ƫ�����ͨ��
%�����߲�࣬һ��ƫС��������ͨ�������1������Ϊ�����߿�����Ӵ���1
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

