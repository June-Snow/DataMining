clear;
clc; 
load 'testdatas.mat'%�����������ÿ�д���һ������ÿ�д���һ���
%PrintTransactions(testdatas);%��ӡ������
% min_sup = 1;%��ʼ����С֧�ֶ�
% min_conf = 0.7;%��ʼ����С���Ŷ�
% [rules_left, rules_right] = Apriori(testdatas, min_sup, min_conf);%����Apriori�㷨
% PrintRules(rules_left, rules_right);%��ӡǿ��������
fid = fopen(strcat('C:\Users\litao\Desktop\FP-tree\sample.txt'), 'w');
fprintf(fid, '%s', '[');
len = length(testdatas);
for i = 1 : len
    val = testdatas(i ,:);
    fprintf(fid, '%s%s', '[', '''');
    for j = 1 : 9
        cell_val = val(j);

        if(cell_val ~= 0)
            if(j == 1)
                fprintf(fid, '%s%d%s', '', cell_val, '''');
            else
            fprintf(fid, '%s%s%d%s', ',', '''', cell_val, '''');
            end
        end
    end
    fprintf(fid, '%s%s', ']', ',');
end
fprintf(fid, '%s', ']');
fclose(fid);
