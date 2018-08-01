clear
load 'testdatas.mat'%读入事务矩阵（每行代表一个事务，每列代表一个项）
%PrintTransactions(testdatas);%打印出事务
% min_sup = 1;%初始化最小支持度
% min_conf = 0.7;%初始化最小置信度
% [rules_left, rules_right] = Apriori(testdatas, min_sup, min_conf);%运算Apriori算法
% PrintRules(rules_left, rules_right);%打印强关联规则

% %% 把mat中的数据转换成矩阵形式
% fid = fopen(strcat('C:\Users\litao\Desktop\FP-tree\sample.txt'), 'w');
% fprintf(fid, '%s', '[');
% len = length(testdatan);
% for i = 1 : len
%     val = testdatan(i ,:);
%     fprintf(fid, '%s%s', '[', '''');
%     for j = 1 : 9
%         cell_val = val(j);
% 
%         if(cell_val ~= 0)
%             if(j == 1)
%                 fprintf(fid, '%s%d%s', '', cell_val, '''');
%             else
%             fprintf(fid, '%s%s%d%s', ',', '''', cell_val, '''');
%             end
%         end
%     end
%     fprintf(fid, '%s%s', ']', ',');
% end
% fprintf(fid, '%s', ']');
% fclose(fid);


lenn = length(testdatas);
for i = 1 : lenn
    vals = testdatas(i ,:);
    strs = '';
    for j = 1 : 9
        cell_val = vals(j);
        if(cell_val ~= 0)
         strs = strcat(strs, num2str(cell_val));
        end
    end
    sums{i,1} = strs;
  
end
suns = sort(sums);
k = 1;
j = 1;
for i = 3 : length(suns) - 1
   vals = suns{i, 1};
   val1s = suns{i + 1, 1};
    if(str2num(vals) ~= str2num(val1s))
        counts{j, 1} = vals;
        counts{j, 2} = k;
        vals = suns(i);
        j = j + 1;
        k = 1;
    else
        k = k + 1;
    end
end
counts{j, 1} = vals;
counts{j, 2} = k;

% fid = fopen(strcat('C:\Users\litao\Desktop\FP-tree\s.txt'), 'w');
% str = '';
% for i = 1 : length(counts)
%     for j = 1 : 9 - length(counts{i, 1});
%         str = strcat(str, ' ');
%     end
%     strnum = strcat(counts{i, 1}, str);
%     fprintf(fid, '%s  %d\t', strnum, counts{i, 2});
% end
% fclose(fid);

load 'testdatan.mat'%读入事务矩阵（每行代表一个事务，每列代表一个项）
lenn = length(testdatan);
for i = 1 : lenn
    valn = testdatan(i ,:);
    strn = '';
    for j = 1 : 9
        cell_val = valn(j);
        if(cell_val ~= 0)
         strn = strcat(strn, num2str(cell_val));
        end
    end
    sumn{i,1} = strn;
  
end
sunn = sort(sumn);
k = 1;
j = 1;
for i = 3 : length(sunn) - 1
   valn = sunn{i, 1};
   val1n = sunn{i + 1, 1};
    if(str2num(valn) ~= str2num(val1n))
        countn{j, 1} = valn;
        countn{j, 2} = k;
        valn = sunn(i);
        j = j + 1;
        k = 1;
    else
        k = k + 1;
    end
end
countn{j, 1} = valn;
countn{j, 2} = k;


%fid = fopen(strcat('C:\Users\litao\Desktop\FP-tree\sample.xls'), 'w');
root1 = 'C:\Users\litao\Desktop\FP-tree\sample.xls';
filewrite = fopen(root1,'w');

D = zeros(300,3);
j = 1;
i = 1;
k = 1;
while (j ~= length(counts) + 1)&&(i ~= length(countn) + 1)
    valn = (countn{i, 1});
    vals = (counts{j, 1});
    if (strcmp(valn,  vals) > 0)%TODO strcmp
        D(k,1) = str2num(counts{j, 1});
        D(k,2) = counts{j, 2};
        j = j + 1;
        k = k + 1;
    elseif(strcmp(valn, vals) < 0)
        D(k,1) = str2num(countn{i, 1});
        D(k,3) = countn{i, 2};
        i = i + 1;
        k = k + 1;
    else 
        D(k,1) = str2num(counts{j, 1});
        D(k,2) = counts{j, 2};
        D(k,3) = countn{i, 2};
        j = j + 1;
        i = i + 1;
        k = k + 1;
    end
    
end

while(j ~= length(counts) + 1)
    D(k,1) = str2num(counts{j, 1});
    D(k,2) = counts{j, 2};
    j = j + 1;
    k = k + 1;
end

while(i ~= length(countn) + 1)
    D(k,1) = str2num(countn{i, 1});
    D(k,3) = countn{i, 2};
    i = i + 1;
    k = k + 1;
end
    
xlswrite(root1,D,'sheet1','A1:C3')

fclose(filewrite);
