function [ imageInf ] = consisBlock( label,WminRow,xNum )
%% 一条线将图像块分成两部分，各部分均具有一致性，图像才具有局部一致性
% 返回抖动判断(0,1)和图像整体偏移量
imageInf = [0,0];
for i = 1:xNum-1   
    [ conFlag1,meanWmin1 ] = consistency( label(1:i,:), WminRow(1:i,:));
    [ conFlag2,meanWmin2 ] = consistency( label(i+1 : end,:), WminRow(i+1 : end,:)); 
    if conFlag1==1 && conFlag2==1 %两块均有一致性
        Wmin = [meanWmin1,meanWmin2];
        [~,idx] = max(abs(Wmin));
        imageInf = [1,Wmin(idx)]; %整体偏移量为绝对值大的一方
        return;
    else
        continue;
    end
end
end

