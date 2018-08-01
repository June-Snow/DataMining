%% ���ڲ鿴���Խ���еģ�'�سӼ�¼����','Ԥ��������','ѵ����������'
% ���ӻ�

clear all;
clc;
save_path = 'C:\Users\Serissa\Desktop\������������2018-0614\';
path = 'C:\Users\Serissa\Desktop\������������2018-0614\AlexNet-20180614_iter_220000predict_result1.xlsx';
[num, txt, raw] = xlsread(path);
names = raw(1:end, 2);
predictWeight = raw(1:end, 3); 
screenWeight = raw(1:end, 4);

len = length(names);
ymd = {};
hms = {};
originWeight = [];
%���룬�����գ�ʱ���룬�سӼ�¼����
for i = 1 : len
    disp(i);
    name = names{i, :};
    str = regexp(name, '_', 'split');%str{1, 5}���أ�str{1, 6}������
    ymd = [ymd; str{1, 6}];
    hms = [hms; str{1, 7}(1:8)];
    originWeight = [originWeight; str2double(str{1,5})];
end
%�������ս�������
[ymd, index] = sort(ymd);
sameDate_hms = hms(index);
originWeight = originWeight(index);
predictWeight = predictWeight(index);
screenWeight = screenWeight(index);
%ѡ��ͬһ�죬��ʱ�����������
i = 1;
while(i < len-1)
    sameDate_originWeight = [];
    sameDate_predictWeight = [];
    sameDate_screenWeight = [];
    sameDate_hms = {};
    str1 = ymd{i, :};
    for j = i+1 : len
        str2 = ymd{j, :};
        if strcmp(str1, str2) == 1
            disp(j);
            sameDate_hms = [sameDate_hms; hms{j, :}];
            sameDate_originWeight = [sameDate_originWeight; originWeight(j, :)];
            sameDate_predictWeight = [sameDate_predictWeight; 120+70*predictWeight{j, :}];
            sameDate_screenWeight = [sameDate_screenWeight; screenWeight{j, :}];
        else            
            break;
        end
    end
    i = j;
    [sameDate_hms, index_hms] = sort(sameDate_hms);
    sameDate_originWeight = sameDate_originWeight(index_hms);
    sameDate_predictWeight = sameDate_predictWeight(index_hms);
    sameDate_screenWeight = sameDate_screenWeight(index_hms);
    plot(1:length(sameDate_originWeight), sameDate_originWeight,'r',...
    1:length(sameDate_predictWeight), sameDate_predictWeight,'g',...
    1:length(sameDate_screenWeight), sameDate_screenWeight,'b');
    ylim([110 200]);
    xlabel('��¼��');
    ylabel('����(KG)');
    legend('�سӼ�¼����','Ԥ��������','ѵ����������');
    save = strcat(save_path, str1, '.png');
    saveas(gcf, save);
end






