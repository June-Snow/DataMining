clc;clear all;
%%
% �� EstShift>=Shift ʱ��������ȷ
% �� EstShift< Shift ʱ���������
%%
data = round(150*rand(1,300));
data = data - mean(data);
moveData = zeros(size(data));
Shift = 10;     %ʵ��ƫ��
EstShift = 10;   %Ԥ��ƫ��
loopNum = 1000;   %ѭ������
count = 0;      %������ȫ��ȷ�Ĵ���
for i = 1:loopNum
% ��������Shift(�� 5)����λ��moveDataΪdata����Shift(�� 5)����λ������ݣ�moveData�����data����Shift(�� 5)����λ
    moveData(1:end-Shift) = data(Shift+1 :end);
    append = round(150*rand(1,Shift));
    moveData(end-Shift+1:end) = append;
    Wmin1 = CorrCoef(data,moveData,EstShift);
% ��������Shift(�� 5)����λ��moveDataΪdata����Shift(�� 5)����λ������ݣ�moveData�����data����Shift(�� 5)����λ
    moveData(Shift+1 :end) = data(1:end-Shift);
    append = round(150*rand(1,Shift));
    moveData(1:Shift) = append;
    Wmin2 = CorrCoef(data,moveData,EstShift);
%���ƶ�
    Wmin3 = CorrCoef(data,data,EstShift);
    if Wmin1==Shift && Wmin2==-Shift && Wmin3==0
        count = count+1;
    end
end
disp(num2str(count/loopNum));
