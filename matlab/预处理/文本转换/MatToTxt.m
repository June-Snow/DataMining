clear all;
clc;
fid = fopen('F:\�ճ�����\��Ҷ�ڵ�\����ͼƬȫ��.txt', 'w');

load 'F:\github\DataMining\Apriori\testdatan.mat'%�����������ÿ�д���һ������ÿ�д���һ���
lenn = length(testdatan);
binary_datas = cell(lenn, 1);
k = 1;
for i = 1 : lenn
    vals = testdatan(i ,:);
    num = zeros(1,9);
    count = 0;
    %������ת���ɶ�Ӧ����ţ������������Ӧ��Ŵ���д1
    for j = 1 : length(vals)
        if(vals(j) ~= 0)
            num(1, vals(j)) = 1;
            count = count + 1;
        end
    end
    %������ת�����ַ���
    str = '';
    %if(count > 1)
        for j = 1 : 9
            str = strcat(str, num2str(num(j)));
        end
        strchar{k, 1} = str;
        k = k + 1;
        fprintf(fid, '%s\t', str);
   % end
    
    %binary_datas{i, 1} = str;
end
strchar = sort(strchar);
strr = '';


