clear all;
clc;
load 'testdatas.mat';
sup = 1;
%datas = zeros(562, 9);
datas = {[1 3 4 7],[1 2 3 6 9], [1 2 3 4 5 6 7],[2 3 6 9 ], [1 2 3 4 5 6 7],[1 2 3 4 5 6 8],...
    [1 2 3 4 5 6 8 9], [1 2 3 4 5 6 7 8],[1 2 3 4 5 7 8], [1 2 3 6], [1 4 7 9]};

mineFP(datas, 1);