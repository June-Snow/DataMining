function [ pixPerc,areaPerc,meanLeafRGB ] = ExtLeafFea( firstFrame,leafMap,Thr,xNum,yNum )
%% ��Ҷ����������ȡ����Ҷ��������Ŀռ����ͼ����������Ŀ�İٷֱȡ�������������ٷֱ�
%%
bwLeaf = leafMap>=Thr;
pixPerc = mean(bwLeaf(:));
areaPerc = AreaPercent(bwLeaf,xNum,yNum);%�˴�ΪʲôΪ0
idx = find(bwLeaf==1);
R = firstFrame(:,:,1);
G = firstFrame(:,:,2);
B = firstFrame(:,:,3);
R = R(idx);
G = G(idx);
B = B(idx);
meanLeafRGB = [mean(R),mean(G),mean(B)];
end

