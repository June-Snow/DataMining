clear all;
clc;
%fid = fopen('F:\�ճ�����\��Ҷ�ڵ�\����ͼƬ.txt', 'w');

load 'testdatan.mat'%�����������ÿ�д���һ������ÿ�д���һ���
lenn = length(testdatan);
binary_datas = cell(lenn, 1);
for i = 1 : lenn
    vals = testdatan(i ,:);
    num = zeros(1,9);
    %������ת���ɶ�Ӧ����ţ������������Ӧ��Ŵ���д1
    for j = 1 : length(vals)
        if(vals(j) ~= 0)
            num(1, vals(j)) = 1;
        end
    end
    %������ת�����ַ���
    str = '';
    for j = 1 : 9
        str = strcat(str, num2str(num(j)));
    end
    
    binary_datas{i, 1} = str;
    
    fprintf(fid, '%s\t', str);
end




