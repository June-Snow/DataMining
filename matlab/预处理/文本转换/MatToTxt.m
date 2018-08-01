clear all;
clc;
fid = fopen('F:\日常工作\树叶遮挡\正常图片全集.txt', 'w');

load 'F:\github\DataMining\Apriori\testdatan.mat'%读入事务矩阵（每行代表一个事务，每列代表一个项）
lenn = length(testdatan);
binary_datas = cell(lenn, 1);
k = 1;
for i = 1 : lenn
    vals = testdatan(i ,:);
    num = zeros(1,9);
    count = 0;
    %把数字转换成对应的序号，并在数组的相应序号处填写1
    for j = 1 : length(vals)
        if(vals(j) ~= 0)
            num(1, vals(j)) = 1;
            count = count + 1;
        end
    end
    %把数组转换成字符串
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


