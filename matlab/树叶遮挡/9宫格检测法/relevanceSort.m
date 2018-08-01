%% 关联排序，把01字符串序列按1出现的次数进行排序，把底出现次数向高出现次数，建立连接关系
clear all
 clc

root = 'F:\日常工作\树叶遮挡\实验结果\树叶遮挡.txt';
fileID = fopen(root);
fax = textscan(fileID,'%s');
len = length(fax{1});
num = fax{1};
num = sort(num);

%numsort = cell(512, 2);
sum = 1;
%fid = fopen(strcat('F:\日常工作\树叶遮挡\树叶遮挡排序结果', '.txt'), 'w');

col = 1;
for i = 2: length(num)
    if (char(num(i - 1)) == char(num(i)));
        sum = sum + 1;        
    else
       % fprintf(fid,'%s %d\t',char(num(i - 1)),sum);
       a = strfind(num(i-1),'1');
        numsort{col, 1} = num(i-1);
        numsort{col, 2} = sum;
        col = col + 1;
        sum = 1;
    end
end
numsort{col, 1} = num(i-1);
numsort{col, 2} = sum;

i1 = 1;   i2 = 1;  i3 = 1;  i4 = 1;  i5 = 1;  i6 = 1;  i7 = 1;  i8 = 1;  i9 = 1;
for i = 1 : length(numsort)
    a = strfind(numsort{i, 1},'1');
    strnum = numsort{i, 1};
    countcell{1}  = numsort{i, 2};
    len = length(a{:});
    switch len
        case 1
            nuncell1(i1, 1) = strnum;
            nuncell1(i1, 2) = countcell;
            i1 = i1 + 1;
        case 2
            nuncell2(i2, 1) = strnum;
            nuncell2(i2, 2) = countcell;
            i2 = i2 + 1;
        case 3
            nuncell3(i3, 1) =  strnum;
            nuncell3(i3, 2) = countcell;
            i3 = i3 + 1;
        case 4
            nuncell4(i4, 1) =  strnum;
            nuncell4(i4, 2) = countcell;
            i4 = i4 + 1;
        case 5
            nuncell5(i5, 1) =  strnum;
            nuncell5(i5, 2) = countcell;
            i5 = i5 + 1;
        case 6
            nuncell6(i6, 1) =  strnum;
            nuncell6(i6, 2) = countcell;
            i6 = i6 + 1;
        case 7
            nuncell7(i7, 1) =  strnum;
            nuncell7(i7, 2) = countcell;
            i7 = i7 + 1;
        case 8
            nuncell8(i8, 1) = strnum;
            nuncell8(i8, 2) = countcell;
            i8 = i8 + 1;
        case 9
            nuncell9(i9, 1) =  strnum;
            nuncell9(i9, 2) = countcell;
            i9 = i9 + 1;
    end
end

i = 1;
if(exist('nuncell1'))
    nuncell{i, :} = nuncell1;
    i = i + 1;
end
if(exist('nuncell2'))
    nuncell{i, :} = nuncell2;
    i = i + 1;
end
if(exist('nuncell3'))
    nuncell{i, :} = nuncell3;
    i = i + 1;
end
if(exist('nuncell4'))
    nuncell{i, :} = nuncell4;
    i = i + 1;
end
if(exist('nuncell5'))
    nuncell{i, :} = nuncell5;
    i = i + 1;
end
if(exist('nuncell6'))
    nuncell{i, :} = nuncell6;
    i = i + 1;
end
if(exist('nuncell7'))
    nuncell{i, :} = nuncell7;
    i = i + 1;
end
if(exist('nuncell8'))
    nuncell{i, :} = nuncell8;
    i = i + 1;
end
if(exist('nuncell9'))
    nuncell{i, :} = nuncell9;
end
%% 建立关联联系
for i = 1 : length(nuncell)-1
    nuncell{i, :} = solveRelevance(nuncell{i, :}, nuncell{i+1, :});
end
%% 进行排序
fid = fopen(strcat('F:\日常工作\树叶遮挡\1', '.txt'), 'w');
for i = 1 : length(nuncell)-1
    c = nuncell{i};
    nuncell{i,:} = sortrows(c, 3);
    for j = 1 : length(nuncell{i , :})
        str1{1} = nuncell{i ,1}{j, 1};
        str2 = nuncell{i, 1}{j, 2};
        str3{1} = nuncell{i, 1}{j, 3};
        fprintf(fid,'%s %d %s\t', char(str1{1,1}), str2, char(str3{1,1}));
    end

end
fclose(fid);
