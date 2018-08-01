function [Wmin] = CorrCoef(preProjValue,curProjValue,EstShift)
%% 计算前一帧与当前帧行投影的相关性
%%
% Wmin<0,则当前帧相对于上一帧左移或上移
% Wmin>0,则当前帧相对于上一帧右移或下移
% Wmin=0,则当前帧相对于上一帧无偏移
%% 1<=w<=2m+1
%%
CC = zeros(2*EstShift+1,1);
for w = -EstShift:EstShift
    if w<=0
        curProjTemp = curProjValue(abs(w)+1:end);
        preProjTemp = preProjValue(1:end-abs(w));
    else
        curProjTemp = curProjValue(1:end-abs(w));
        preProjTemp = preProjValue(abs(w)+1:end);
    end    
    temp = (curProjTemp - preProjTemp).^2;
    CC(w+EstShift+1) = sum(temp);    
end

[~,Wmin] = min(CC);
Wmin = Wmin-EstShift-1;
end

