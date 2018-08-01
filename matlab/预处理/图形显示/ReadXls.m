clear all;
clc;
xls_path = 'C:\Users\litao\Desktop\litao-FP\4.xlsx';
[NUM, TXT, RAW] = xlsread(xls_path); 
start_position = 1;
end_position = 1;
 n = 3;
for i = 1 : length(TXT)
    val = TXT{i, 1};
    sum_s = 0;
    sum_n = 0;
    %if(n ~= length(val))
    end_position = length(TXT);
        %求和求概率
        for j = start_position : end_position - 1
            sum_s = sum_s + NUM(j, 1);
            sum_n = sum_n + NUM(j, 2);
        end
        matcell = cell((end_position - start_position), 3);
%         sortcel1 = cell((end_position - start_position), 3);
%         sortcel2 = cell((end_position - start_position), 3);
        for j = 1 : (end_position - start_position)
            matcell(j, 1) = TXT(start_position + j - 1, 1);
            matcell(j, 2) = num2cell(NUM(start_position + j - 1, 1) / sum_s);
            matcell(j, 3) = num2cell(NUM(start_position + j - 1, 2) / sum_n);
        end
        %数据分类
        k1 = 1; k2 = 1;
        for j = 1 : (end_position - start_position)
            if(cell2mat(matcell(j, 3)) > cell2mat(matcell(j, 2)))
                sortcel1(k1, :) = matcell(j, :);
                k1 = k1 + 1;
            else
                sortcel2(k2, :) = matcell(j, :);
                k2 = k2 + 1;
            end
        end
        %排序拼接
        sortcel1 = sortrows(sortcel1, -3);
        sortcel2 = sortrows(sortcel2, 2);
        len = length(sortcel1(:, 1));
        for j = 1 : len
            matcell(j, :) = sortcel1(j, :);
        end
        for j = 1 : length(sortcel2(:, 1))
            matcell(len + j, :) = sortcel2(j, :);
        end
%       matcell = sortrows(matcell, -3);
        priori = sum_n / (sum_n + sum_s);%正常先验概率
        position = threshold(priori, matcell);%求全局最优阈值

        start_position = i;%下次开始的起始位置
        end_position = end_position + 1;
        n = length(val);
%     else 
%         end_position = end_position + 1;
%     end
    
end





