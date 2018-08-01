function [ histHsv ] = HistHsvFea( HSVImg )
%% 提取HSV空间非均匀量化直方图
%% h、s、v重计算
h = HSVImg(:,:,1);
s = HSVImg(:,:,2);
v = HSVImg(:,:,3);
% h
h(h>330 | h<=22) = 0;
h(h>22 & h<=45) = 1;
h(h>45 & h<=70) = 2;
h(h>70 & h<=155) = 3;
h(h>155 & h<=186) = 4;
h(h>186 & h<=278) = 5;
h(h>278 & h<=330) = 6;
% s
s(s>0.2 & s<=0.65) = 0;
s(s>0.65 & s<=1) = 1;
% v
v(v>0.2 & v<=0.7) = 0;
v(v>0.7 & v<=1) = 1;
%% 计算统计直方图
L = zeros(1,36);
[r,c] = size(h);
for i = 1:r
    for j = 1:c
        if v(i,j)<0.2
            L(1) = L(1)+1;
        elseif s(i,j)<=0.2 && v(i,j)>=0.2 && v(i,j)>=0.2 
            L(floor((v(i,j)-0.2)*10)+2) = L(floor((v(i,j)-0.2)*10)+2) + 1;
        elseif s(i,j)<=0.2 && v(i,j)>=0.8
            L(8) = L(8)+1;
        else
            L(4*h(i,j)+2*s(i,j)+v(i,j)+9) = L(4*h(i,j)+2*s(i,j)+v(i,j)+9) + 1;
        end
    end
end
%%
histHsv = L;
end

