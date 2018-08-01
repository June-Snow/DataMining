%% ���ڲ鿴�سӼ�¼����ֵ��ѵ����������ֵ�Ŀ��ӻ�
clear all;
clc;
save_path = 'C:\Users\Serissa\Desktop\1\';
fid = fopen('C:\Users\Serissa\Desktop\1\ScreenImage-unique.txt');
context = textscan(fid, '%s%s');
fclose(fid);
[B] = context{1, 2};
[A] = context{1, 1};
len = length(A);
i = 1;%171100;
while(i < len-1)
    origin_weight_score = [];
    screen_weight_score = [];
    namei = A{i, :};
    stri = regexp(namei, '_', 'split');%str{1, 5}���أ�str{1, 6}������
    origin_weight_score = [origin_weight_score,str2double(stri{1,5})];
    screen_weight_score = [screen_weight_score, str2double(B{i})];
    for j = i+1 : len
        namej = A{j, :};
        strj = regexp(namej, '_', 'split');
        str =strj{1, 7};
        if strcmp(stri{1, 6}, strj{1, 6}) == 1
            origin_weight_score = [origin_weight_score, str2double(strj{1,5})];
            screen_weight_score = [screen_weight_score, str2double(B{j})];
        else
            break;
        end
    end
    i = j;
    plot(1:length(origin_weight_score), origin_weight_score, 1:length(screen_weight_score), screen_weight_score);
    ylim([110 200])
    legend('�سӼ�¼����','ѵ����������');
    save = strcat(save_path, stri{1, 6}, '_0.png');
    saveas(gcf, save);
    close all;
end