function [ pixPerc,areaPerc,meanLeafRGB ] = ExtLeafFea( firstFrame,leafMap,Thr,xNum,yNum )
%% 树叶区域特征提取：树叶的像素数目占整幅图像总像素数目的百分比、覆盖区域面积百分比
%%
bwLeaf = leafMap>=Thr;
pixPerc = mean(bwLeaf(:));
areaPerc = AreaPercent(bwLeaf,xNum,yNum);%此处为什么为0
idx = find(bwLeaf==1);
R = firstFrame(:,:,1);
G = firstFrame(:,:,2);
B = firstFrame(:,:,3);
R = R(idx);
G = G(idx);
B = B(idx);
meanLeafRGB = [mean(R),mean(G),mean(B)];
end

