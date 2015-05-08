clear all;
clc;
%fid = fopen('F:\日常工作\树叶遮挡\正常图片.txt', 'w');

load 'testdatan.mat'%读入事务矩阵（每行代表一个事务，每列代表一个项）
lenn = length(testdatan);
binary_datas = cell(lenn, 1);
for i = 1 : lenn
    vals = testdatan(i ,:);
    num = zeros(1,9);
    %把数字转换成对应的序号，并在数组的相应序号处填写1
    for j = 1 : length(vals)
        if(vals(j) ~= 0)
            num(1, vals(j)) = 1;
        end
    end
    %把数组转换成字符串
    str = '';
    for j = 1 : 9
        str = strcat(str, num2str(num(j)));
    end
    
    binary_datas{i, 1} = str;
    
    fprintf(fid, '%s\t', str);
end




