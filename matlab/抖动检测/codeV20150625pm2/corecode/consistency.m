function [ conFlag,meanWmin ] = consistency( label,Wmin )
%% 有位移且位移方向一致或无位移，才算具有一致性
% 返回一致性判断及整体位移
%% 初始化
conFlag = 0;
meanWmin = 0;
%%
[r c] = size(label);
sumLab = sum(label(:));
if sumLab==0 || sumLab==r*c 
    if sumLab==0;%无位移
        conFlag = 1;
        return;
    else% 有位移，再检测位移方向
        Wlab = Wmin<0;
        sumWLab = sum(Wlab(:));
        WminFlag = sumWLab==0 | sumWLab==r*c ;
        if WminFlag~=1 %位移方向不一致
            return;
        else %位移方向一致
            conFlag = 1;
            meanWmin = mean(Wmin(:));
        end
    end
else
    return;
end