%% 用于查看地秤记录数据可视化，展示以记录为横轴和以时间为横轴的体重变化曲线
clear all;
clc;
save_path = 'C:\Users\Serissa\Desktop\ccc\';
fid = fopen('C:\Users\Serissa\Desktop\ccc\origin1-1.txt');
context = textscan(fid, '%s%s');
fclose(fid);
[A] = context{:};
len = length(A);

i = 1;%171100;
while(i < len-1)
    imageName = [];
    hms = [];
    weights = [];
    namei = A{i, :};
    stri = regexp(namei, '_', 'split');%str{1, 5}体重，str{1, 6}年月日
    for j = i+1 : len
        namej = A{j, :};
        strj = regexp(namej, '_', 'split');
        str =strj{1, 7};
        if strcmp(stri{1, 6}, strj{1, 6}) == 1
            imageName = [imageName,  str2double(strj{1,5})];
            weights = [weights, str2double(strj{1,5})];
            hms = [hms; str(1:8)];
        else
            
            break;
        end
    end
    i = j;
    plot(1:length(imageName), imageName);
    ylim([130 170])
    save = strcat(save_path, stri{1, 6}, '_0.png');
    saveas(gcf, save);
    save = strcat(save_path, stri{1, 6}, '_1.png');
    distribution(hms, weights, save);
end
%plot(1:len, weight_score);

