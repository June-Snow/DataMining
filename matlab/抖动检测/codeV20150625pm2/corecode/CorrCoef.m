function [Wmin] = CorrCoef(preProjValue,curProjValue,EstShift)
%% ����ǰһ֡�뵱ǰ֡��ͶӰ�������
%%
% Wmin<0,��ǰ֡�������һ֡���ƻ�����
% Wmin>0,��ǰ֡�������һ֡���ƻ�����
% Wmin=0,��ǰ֡�������һ֡��ƫ��
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

