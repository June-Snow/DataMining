function [ PreRowProjValue ]= GrayProject(grayImg)
%% ������ͶӰֵ
%%

rowSum = sum(grayImg,2);
rowAvg = mean(rowSum);
PreRowProjValue = rowSum - rowAvg;

end