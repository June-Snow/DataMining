function [  imageInf ] = getImageInf( blockInf )
%% 根据图像块偏移量计算图片的整体信息：
% 抖动判断（0,1）、方向（0-360）、幅度（>0）
%%
WminRow = blockInf(:,:,1);
WminCol = blockInf(:,:,2);
[xNum,yNum] = size(WminRow);
%% 
label =  WminRow ~= 0 | WminCol ~= 0;%不管是什么位移，都必须具有一定的轴对称性
imageRow = consisImg( label, WminRow,xNum,yNum ); %根据块的水平位移计算图像水平位移一致性
imageCol = consisImg( label, WminCol,xNum,yNum ); %根据块的垂直位移计算图像垂直位移一致性
sumFlag = imageRow(1) + imageCol(1);
switch(sumFlag)
    case 0
        imageInf = [0,0,0];
    case 1
        if imageRow(1)==1 %左右移动
            if imageRow(2)<0
                dir = 180;
            else
                dir = 0;
            end
            imageInf = [1,dir,abs(imageRow(2))];
        else %上下移动
            if imageCol(2)<0
                dir = 270;
            else
                dir = 90;
            end
            imageInf = [1,dir,abs(imageCol(2))];
        end            
    case 2 %斜着移动
        dir = atan2(imageCol(2),imageRow(2));
        dir = dir*180/pi;
        if dir<0
            dir = dir+360;
        end
        amp = sqrt(imageRow(2)^2 +imageCol(2)^2);
        imageInf = [1,dir,amp];
end
end

