function [ imageInf ] = consisImg( label, WminRow,xNum,yNum )
%% 判断图像位移一致性，返回抖动判断(0,1)和图像整体偏移量
%% 判断图像块全局一致性
[ conFlag,meanWmin ] = consistency( label, WminRow); %块一致性计算，返回位移及方向是否一致
if conFlag==1 
    if meanWmin==0 %具有一致性，但无偏移
        imageInf = [ 0,0 ]; %不抖动，偏移量为0
    else %具有一致性，偏移量为平均量
        imageInf = [ 1,meanWmin ];
    end
    return;  %若图像整体一致，则返回，不用判断局部一致性  
end
%% 判断图像块局部一致性
imageInf = consisBlock( label,WminRow,xNum );%局部横向一致性判断
if sum(imageInf==[0,0])==2 %如果横向上找不到一致性，就在纵向上找
    imageInf = consisBlock( label',WminRow',yNum );
else
    return;
end
end

