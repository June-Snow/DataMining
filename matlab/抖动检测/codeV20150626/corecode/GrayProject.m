function [ PreRowProjValue ]= GrayProject(grayImg)
%% 计算行投影值
%%

rowSum = sum(grayImg,2);
rowAvg = mean(rowSum);
PreRowProjValue = rowSum - rowAvg;

end