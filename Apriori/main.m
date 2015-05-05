clear;
clc; 
load 'testdatas.mat'%读入事务矩阵（每行代表一个事务，每列代表一个项）
%PrintTransactions(testdatas);%打印出事务
% min_sup = 1;%初始化最小支持度
% min_conf = 0.7;%初始化最小置信度
% [rules_left, rules_right] = Apriori(testdatas, min_sup, min_conf);%运算Apriori算法
% PrintRules(rules_left, rules_right);%打印强关联规则
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
