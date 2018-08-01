clc;clear all;
%%
% 当 EstShift>=Shift 时，计算正确
% 当 EstShift< Shift 时，计算错误
%%
data = round(150*rand(1,300));
data = data - mean(data);
moveData = zeros(size(data));
Shift = 10;     %实际偏移
EstShift = 10;   %预估偏移
loopNum = 1000;   %循环次数
count = 0;      %计算完全正确的次数
for i = 1:loopNum
% 测试左移Shift(如 5)个单位，moveData为data左移Shift(如 5)个单位后的数据，moveData相对于data右移Shift(如 5)个单位
    moveData(1:end-Shift) = data(Shift+1 :end);
    append = round(150*rand(1,Shift));
    moveData(end-Shift+1:end) = append;
    Wmin1 = CorrCoef(data,moveData,EstShift);
% 测试右移Shift(如 5)个单位，moveData为data右移Shift(如 5)个单位后的数据，moveData相对于data左移Shift(如 5)个单位
    moveData(Shift+1 :end) = data(1:end-Shift);
    append = round(150*rand(1,Shift));
    moveData(1:Shift) = append;
    Wmin2 = CorrCoef(data,moveData,EstShift);
%不移动
    Wmin3 = CorrCoef(data,data,EstShift);
    if Wmin1==Shift && Wmin2==-Shift && Wmin3==0
        count = count+1;
    end
end
disp(num2str(count/loopNum));
