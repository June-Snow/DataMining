%% 用于查看测试结果中的，'地秤记录体重','预测结果体重','训练修正体重'
% 可视化

clear all;
clc;
save_path = 'C:\Users\Serissa\Desktop\三种体重数据2018-0614\';
path = 'C:\Users\Serissa\Desktop\三种体重数据2018-0614\AlexNet-20180614_iter_220000predict_result1.xlsx';
[num, txt, raw] = xlsread(path);
names = raw(1:end, 2);
predictWeight = raw(1:end, 3); 
screenWeight = raw(1:end, 4);

len = length(names);
ymd = {};
hms = {};
originWeight = [];
%分离，年月日，时分秒，地秤记录体重
for i = 1 : len
    disp(i);
    name = names{i, :};
    str = regexp(name, '_', 'split');%str{1, 5}体重，str{1, 6}年月日
    ymd = [ymd; str{1, 6}];
    hms = [hms; str{1, 7}(1:8)];
    originWeight = [originWeight; str2double(str{1,5})];
end
%按年月日进行排序
[ymd, index] = sort(ymd);
sameDate_hms = hms(index);
originWeight = originWeight(index);
predictWeight = predictWeight(index);
screenWeight = screenWeight(index);
%选择同一天，按时分秒进行排序
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
    xlabel('记录数');
    ylabel('体重(KG)');
    legend('地秤记录体重','预测结果体重','训练修正体重');
    save = strcat(save_path, str1, '.png');
    saveas(gcf, save);
end






