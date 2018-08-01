
clear all;
clc;
path = 'C:\Users\LiTao\Desktop\1080p\';
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
leafNum = length(img_path_list);
leafName = cell(leafNum, 1);
for i=1 : leafNum
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    leafName{i, 1} = (strcat(name, ext));
end
path1 = 'E:\leafOcclusion\b-Part2-1080p\3x3predict_result.xlsx';
[~, name1, ext1] = fileparts(path1);
[data1, preName1] = xlsread(path1);
allNum = length(data1);
flagePre1 = zeros(allNum, 1);

path2 = 'E:\leafOcclusion\b-Part2-1080p\3x4predict_result.xlsx';
[~, name2, ext2] = fileparts(path2);
[data2, preName2] = xlsread(path2);
flagePre2 = zeros(allNum, 1);

path3 = 'E:\leafOcclusion\b-Part2-1080p\3x5predict_result.xlsx';
[~, name3, ext3] = fileparts(path3);
[data3, preName3] = xlsread(path3);
flagePre3 = zeros(allNum, 1);

path4 = 'E:\leafOcclusion\b-Part2-1080p\4x4predict_result.xlsx';
[~, name4, ext4] = fileparts(path4);
[data4, preName4] = xlsread(path4);
flagePre4 = zeros(allNum, 1);

path5 = 'E:\leafOcclusion\b-Part2-1080p\4x5predict_result.xlsx';
[~, name5, ext5] = fileparts(path5);
[data5, preName5] = xlsread(path5);
flagePre5 = zeros(allNum, 1);

path6 = 'E:\leafOcclusion\b-Part2-1080p\4x6predict_result.xlsx';
[~, name6, ext6] = fileparts(path6);
[data6, preName6] = xlsread(path6);
flagePre6 = zeros(allNum, 1);

path7 = 'E:\leafOcclusion\b-Part2-1080p\5x5predict_result.xlsx';
[~, name7, ext7] = fileparts(path7);
[data7, preName7] = xlsread(path7);
flagePre7 = zeros(allNum, 1);

path8 = 'E:\leafOcclusion\b-Part2-1080p\5x6predict_result.xlsx';
[~, name8, ext8] = fileparts(path8);
[data8, preName8] = xlsread(path8);
flagePre8 = zeros(allNum, 1);

path9 = 'E:\leafOcclusion\b-Part2-1080p\6x6predict_result.xlsx';
[~, name9, ext9] = fileparts(path9);
[data9, preName9] = xlsread(path9);
flagePre9 = zeros(allNum, 1);

for i = 1 : allNum
    for j = 1 : leafNum
        if strcmp(preName1(i, 1), leafName(j, 1)) == 1
            flagePre1(i) = 1;
        end
        if strcmp(preName2(i, 1), leafName(j, 1)) == 1
            flagePre2(i) = 1;
        end
        if strcmp(preName3(i, 1), leafName(j, 1)) == 1
            flagePre3(i) = 1;
        end
        if strcmp(preName4(i, 1), leafName(j, 1)) == 1
            flagePre4(i) = 1;
        end
        if strcmp(preName5(i, 1), leafName(j, 1)) == 1
            flagePre5(i) = 1;
        end
        if strcmp(preName6(i, 1), leafName(j, 1)) == 1
            flagePre6(i) = 1;
        end
        if strcmp(preName7(i, 1), leafName(j, 1)) == 1
            flagePre7(i) = 1;
        end
        if strcmp(preName8(i, 1), leafName(j, 1)) == 1
            flagePre8(i) = 1;
        end
        if strcmp(preName9(i, 1), leafName(j, 1)) == 1
            flagePre9(i) = 1;
        end
    end
end

TPR1 = zeros(1, allNum);
FPR1 = zeros(1, allNum);
TPR2 = zeros(1, allNum);
FPR2 = zeros(1, allNum);
TPR3 = zeros(1, allNum);
FPR3 = zeros(1, allNum);
TPR4 = zeros(1, allNum);
FPR4 = zeros(1, allNum);
TPR5 = zeros(1, allNum);
FPR5 = zeros(1, allNum);
TPR6 = zeros(1, allNum);
FPR6 = zeros(1, allNum);
TPR7 = zeros(1, allNum);
FPR7 = zeros(1, allNum);
TPR8 = zeros(1, allNum);
FPR8 = zeros(1, allNum);
TPR9 = zeros(1, allNum);
FPR9 = zeros(1, allNum);
min1 = 10;
min2 = 10;
min3 = 10;
min4 = 10;
min5 = 10;
min6 = 10;
min7 = 10;
min8 = 10;
min9 = 10;
for i = 1 : allNum
    leafCount = 0;%预测为树叶样本中的树叶样本的数量
    [m1, n1] = find(flagePre1(1:i) == 1);
    if isempty(n1)
        leafCount1 = 0;
    else
        leafCount1 = length(n1);
    end 
    arCount1 = i - leafCount1;           
    %正常为正样本，树叶为负样本
    FN1 = arCount1;                      %被模型预测为负的正样本
    TP1 = allNum - i -(leafNum-leafCount1);%被模型预测为正的正样本
    TPR1(i) = TP1/(TP1+FN1);    
    TN1 = leafCount1;                    %被模型预测为负的负样本
    FP1 = leafNum-leafCount1;            %被模型预测为正的负样本
    FPR1(i) = FP1/(FP1+TN1);
    if min1 > sqrt(FPR1(i).^2 + (1-TPR1(i)).^2)
        min1 = sqrt(FPR1(i).^2 + (1-TPR1(i)).^2);
        x11 = leafCount1;
        x1 = FPR1(i);
        y11 = arCount1;
        y1 = TPR1(i);
    end
    
    [m2, n2] = find(flagePre2(1:i) == 1);
    if isempty(n2)
        leafCount2 = 0;
    else
        leafCount2 = length(n2);
    end    
    arCount2 = i - leafCount2;           
    %正常为正样本，树叶为负样本
    FN2 = arCount2;                      %被模型预测为负的正样本
    TP2 = allNum - i -(leafNum-leafCount2);%被模型预测为正的正样本
    TPR2(i) = TP2/(TP2+FN2);    
    TN2 = leafCount2;                    %被模型预测为负的负样本
    FP2 = leafNum-leafCount2;            %被模型预测为正的负样本
    FPR2(i) = FP2/(FP2+TN2);
    if min2 > sqrt(FPR2(i).^2 + (1-TPR2(i)).^2)
        min2 = sqrt(FPR2(i).^2 + (1-TPR2(i)).^2);
        x22 = leafCount2;
        x2 = FPR2(i);
        y22 = arCount2;
        y2 = TPR2(i);
    end
    
    [m3, n3] = find(flagePre3(1:i) == 1);
    if isempty(n3)
        leafCount3 = 0;
    else
        leafCount3 = length(n3);
    end    
    arCount3 = i - leafCount3;           
    %正常为正样本，树叶为负样本
    FN3 = arCount3;                      %被模型预测为负的正样本
    TP3 = allNum - i -(leafNum-leafCount3);%被模型预测为正的正样本
    TPR3(i) = TP3/(TP3+FN3);    
    TN3 = leafCount3;                    %被模型预测为负的负样本
    FP3 = leafNum-leafCount3;            %被模型预测为正的负样本
    FPR3(i) = FP3/(FP3+TN3);
    if min3 > sqrt(FPR3(i).^2 + (1-TPR3(i)).^2)
        min3 = sqrt(FPR3(i).^2 + (1-TPR3(i)).^2);
        x33 = leafCount3;
        x3 = FPR3(i);
        y33 = arCount3;
        y3 = TPR3(i);
    end
    
    [m4, n4] = find(flagePre4(1:i) == 1);
    if isempty(n4)
        leafCount4 = 0;
    else
        leafCount4 = length(n4);
    end    
    arCount4 = i - leafCount4;           
    %正常为正样本，树叶为负样本
    FN4 = arCount4;                      %被模型预测为负的正样本
    TP4 = allNum - i -(leafNum-leafCount4);%被模型预测为正的正样本
    TPR4(i) = TP4/(TP4+FN4);    
    TN4 = leafCount4;                    %被模型预测为负的负样本
    FP4 = leafNum-leafCount4;            %被模型预测为正的负样本
    FPR4(i) = FP4/(FP4+TN4);
    if min4 > sqrt(FPR4(i).^2 + (1-TPR4(i)).^2)
        min4 = sqrt(FPR4(i).^2 + (1-TPR4(i)).^2);
        x44 = leafCount4;
        x4 = FPR4(i);
        y44 = arCount4;
        y4 = TPR4(i);
    end
    
    [m5, n5] = find(flagePre5(1:i) == 1);
    if isempty(n5)
        leafCount5 = 0;
    else
        leafCount5 = length(n5);
    end    
    arCount5 = i - leafCount5;           
    %正常为正样本，树叶为负样本
    FN5 = arCount5;                      %被模型预测为负的正样本
    TP5 = allNum - i -(leafNum-leafCount5);%被模型预测为正的正样本
    TPR5(i) = TP5/(TP5+FN5);    
    TN5 = leafCount5;                    %被模型预测为负的负样本
    FP5 = leafNum-leafCount5;            %被模型预测为正的负样本
    FPR5(i) = FP5/(FP5+TN5);
    if min5 > sqrt(FPR5(i).^2 + (1-TPR5(i)).^2)
        min5 = sqrt(FPR5(i).^2 + (1-TPR5(i)).^2);
        x55 = leafCount5;
        x5 = FPR5(i);
        y55 = arCount5;
        y5 = TPR5(i);
    end
    
    [m6, n6] = find(flagePre6(1:i) == 1);
    if isempty(n6)
        leafCount6 = 0;
    else
        leafCount6 = length(n6);
    end    
    arCount6 = i - leafCount6;           
    %正常为正样本，树叶为负样本
    FN6 = arCount6;                      %被模型预测为负的正样本
    TP6 = allNum - i -(leafNum-leafCount6);%被模型预测为正的正样本
    TPR6(i) = TP6/(TP6+FN6);    
    TN6 = leafCount6;                    %被模型预测为负的负样本
    FP6 = leafNum-leafCount6;            %被模型预测为正的负样本
    FPR6(i) = FP6/(FP6+TN6);
    if min6 > sqrt(FPR6(i).^2 + (1-TPR6(i)).^2)
        min6 = sqrt(FPR6(i).^2 + (1-TPR6(i)).^2);
        x66 = leafCount6;
        x6 = FPR6(i);
        y66 = arCount6;
        y6 = TPR6(i);
    end 
    
    [m7, n7] = find(flagePre7(1:i) == 1);
    if isempty(n7)
        leafCount7 = 0;
    else
        leafCount7 = length(n7);
    end    
    arCount7 = i - leafCount7;           
    %正常为正样本，树叶为负样本
    FN7 = arCount7;                      %被模型预测为负的正样本
    TP7 = allNum - i -(leafNum-leafCount7);%被模型预测为正的正样本
    TPR7(i) = TP7/(TP7+FN7);    
    TN7 = leafCount7;                    %被模型预测为负的负样本
    FP7 = leafNum-leafCount7;            %被模型预测为正的负样本
    FPR7(i) = FP7/(FP7+TN7);
    if min7 > sqrt(FPR7(i).^2 + (1-TPR7(i)).^2)
        min7 = sqrt(FPR7(i).^2 + (1-TPR7(i)).^2);
        x77 = leafCount7;
        x7 = FPR7(i);
        y77 = arCount7;
        y7 = TPR7(i);
    end 
    
    [m8, n8] = find(flagePre8(1:i) == 1);
    if isempty(n8)
        leafCount8 = 0;
    else
        leafCount8 = length(n8);
    end    
    arCount8 = i - leafCount8;           
    %正常为正样本，树叶为负样本
    FN8 = arCount8;                      %被模型预测为负的正样本
    TP8 = allNum - i -(leafNum-leafCount8);%被模型预测为正的正样本
    TPR8(i) = TP8/(TP8+FN8);    
    TN8 = leafCount8;                    %被模型预测为负的负样本
    FP8 = leafNum-leafCount8;            %被模型预测为正的负样本
    FPR8(i) = FP8/(FP8+TN8);
    if min8 > sqrt(FPR8(i).^2 + (1-TPR8(i)).^2)
        min8 = sqrt(FPR8(i).^2 + (1-TPR8(i)).^2);
        x88 = leafCount8;
        x8 = FPR8(i);
        y88 = arCount8;
        y8 = TPR8(i);
    end 
    
    [m9, n9] = find(flagePre9(1:i) == 1);
    if isempty(n9)
        leafCount9 = 0;
    else
        leafCount9 = length(n9);
    end    
    arCount9 = i - leafCount9;           
    %正常为正样本，树叶为负样本
    FN9 = arCount9;                      %被模型预测为负的正样本
    TP9 = allNum - i -(leafNum-leafCount9);%被模型预测为正的正样本
    TPR9(i) = TP9/(TP9+FN9);    
    TN9 = leafCount9;                    %被模型预测为负的负样本
    FP9 = leafNum-leafCount9;            %被模型预测为正的负样本
    FPR9(i) = FP9/(FP9+TN9);
    if min9 > sqrt(FPR9(i).^2 + (1-TPR9(i)).^2)
        min9 = sqrt(FPR9(i).^2 + (1-TPR9(i)).^2);
        x99 = leafCount9;
        x9 = FPR9(i);
        y99 = arCount9;
        y9 = TPR9(i);
    end 
    
end
plot(FPR1, TPR1, '-r', FPR2, TPR2, '-g', FPR3, TPR3, '-b', FPR4, TPR4, ':r',FPR5, TPR5, ':g',FPR6, TPR6, ':b', FPR7, TPR7, ':.r',FPR8, TPR8, ':.g',FPR9, TPR9, ':.b', x1, y1, '-*r', x2, y2, '-*g', x3, y3, '-*b', x4, y4, ':*r', x5, y5, ':*g', x6, y6, ':*b', x7, y7, ':or', x8, y8, ':og', x9, y9, ':ob');%
%plot(FPR1, TPR1, ':b', FPR2, TPR2, '-r', x1, y1, ':+b', x2, y2, '-*r');%
legend('3x3', '3x4', '3x5', '4×4', '4×5', '4×6', '5×5', '5×6', '6×6');
%legend(name1, name2, name3, name4,name5, name6);
% text(x1, y1, '\leftarrow本文方法');
% text(x2, y2, '\leftarrow整体方法');

xlabel('负正类率（FPR）');
ylabel('真正类率（TPR）');



