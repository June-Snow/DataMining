%% 
%把两个txt中的数据排序，然后写入excel中
root1 = 'F:\日常工作\树叶遮挡\树叶遮挡与正常图片.xls';
filewrite = fopen(root1,'w');
root2 = 'C:\Users\litao\Desktop\FP-tree检测结果\树叶.txt';
fileopenright = fopen(root2,'r');
root3 = 'C:\Users\litao\Desktop\FP-tree检测结果\正常.txt';
fileopencover = fopen(root3,'r');
A = textscan(fileopenright,'%s%s');
C = textscan(fileopencover,'%s%s');
A = [A{1,1}, A{1,2}];
C = [C{1,1}, C{1,2}];
j = 1;
i = 1;
k = 1;
D = zeros(162,3);
while (j ~= length(A) + 1)&&(i ~= length(C) + 1)
    if (str2num(cell2mat(C(i,1))) > str2num(cell2mat(A(j,1))))
        D(k,1) = str2num(cell2mat(A(j,1)));
        D(k,2) = str2num(cell2mat(A(j,2)));
        j = j + 1;
        k = k + 1;
    elseif(str2num(cell2mat(C(i,1))) < str2num(cell2mat(A(j,1))))
        D(k,1) = str2num(cell2mat(C(i,1)));
        D(k,3) = str2num(cell2mat(C(i,2)));
        i = i + 1;
        k = k + 1;
    else 
        D(k,1) = str2num(cell2mat(A(j,1)));
        D(k,2) = str2num(cell2mat(A(j,2)));
%         k = k + 1;
%         D(k,1) = str2num(cell2mat(C(i,1)));
        D(k,3) = str2num(cell2mat(C(i,2)));
        j = j + 1;
        i = i + 1;
        k = k + 1;
    end
    
end

while(j ~= length(A) + 1)
    D(k,1) = str2num(cell2mat(A(j,1)));
    D(k,2) = str2num(cell2mat(A(j,2)));
    j = j + 1;
    k = k + 1;
end

while(i ~= length(C) + 1)
    D(k,1) = str2num(cell2mat(C(i,1)));
    D(k,3) = str2num(cell2mat(C(i,2)));
    i = i + 1;
    k = k + 1;
end

data = cell(length(D(:, 1)), 3);
for i = 1 : length(D(:, 1))
    num = D(i, 1);
    num = num2str(num);
    str = '';
    for j = 1 : length(num)
        l = length(num);
        if(j == 1)
            str = num(j);
        else
            str = strcat(str, ',', num(j));
        end
    end
    data{i, 1} = str;
    data{i, 2} = D(i, 2);
    data{i, 3} = D(i, 3);
end
xlswrite('3.xls', data, 'sheet1', 'A:C')

fclose(fileopenright);
fclose(fileopencover);
fclose(filewrite);














