clear all
clc
%% ��ȡtxt���ַ��������ֲ��֣��ѽ������д��txt��
%% ���ַ�����ʽ��ȡtxt
% fid = fopen('C:\Users\litao\Desktop\FP-tree�����\�½��ı��ĵ�.txt', 'r');
% file = textscan(fid, '%s');
% len = length(file{1});
% num = file{1};
%% ��ȡtxt�е�һ��
fidin = fopen('C:\Users\litao\Desktop\FP-tree�����\�½��ı��ĵ�.txt');
%data = zeros(502, 2);
k = 1;
while ~feof(fidin)
    tline = fgetl(fidin);
    str_split = regexp(tline, ' ', 'split');
    len = length(str_split);
    numzero = zeros(9,1);
    str = '';
    for i = 1 : len - 1
%         binary_str = isstrprop(str_split(i), 'digit');%ת���ɶ�����
%         a = (binary_str);
%         num = str2num(a);
        pat = '[0-9]*';
        if(i == 1)
            num = regexp(str_split(i), pat, 'match');
            numzero(i, 1) = str2num(cell2mat(num{1}));
        else
            num = regexp(str_split(i), pat, 'match');
            numzero(i, 1) = str2num(cell2mat(num{1}));
        end
    end
    numzero = sort(numzero);
    for j = 1 : 9
        if ~(numzero(j, 1) == 0)
            str = strcat(str, num2str(numzero(j, 1)));
        end
    end
    num = regexp(str_split(len), pat, 'match');
    count_num = str2num(cell2mat(num{1}));
    data(k, 1) = str2num(str);
    data(k, 2) = count_num;
    k = k + 1;
end
[m, n] = sort(data(:,1));
data(:, 1) = m;
data(:, 2) = data(n, 2);
%xlswrite('1.xls',data, 'sheet1', 'A:B');
fid = fopen('C:\Users\litao\Desktop\FP-tree�����\����.txt', 'wt');
for i = 1 : length(data(:, 1))
    fprintf(fid, '%d %d\n', data(i, 1), data(i, 2));
end
fclose(fid);


