function stringToNumber(save_path, source_path)
%% 把字符串中的1转换成对应的序号，以数组的形式存储到txt文件中
% file_r = fopen('F:\市局第二次样本图片整理\树叶遮挡.txt', 'r');
% file_w = fopen('F:\市局第二次样本图片整理\树叶矩阵.txt', 'w');
file_r = fopen(source_path, 'r');
file_w = fopen(save_path, 'w');
if(file_r < 0)
    return;
end
fax = textscan(file_r,'%s');
fclose(file_r);
num = fax{1};
num = sort(num);
fprintf(file_w, '%s', '[');
for i = 1 : length(num)
    val = num{i};
    fprintf(file_w, '%s', '[');
    k = 1;
    for j = 1 : length(val)
        %a = val(j);
        if(str2num(val(j)) == 1)
            if(k == 1)
                fprintf(file_w, '%s%d%s', '''', j, '''');
                k = k + 1;
            else
                fprintf(file_w, '%s%s%d%s', ',', '''', j, '''');
            end
                %fprintf(file_w, '%s%s%d%s', ',', '''', j, '''');  
            
        end
    end
    if(i ~= length(num))
        fprintf(file_w, '%s%s\t', ']', ',');
    else
        fprintf(file_w, '%s\t', ']');
    end
    
end
fprintf(file_w, '%s', ']');
fclose(file_w);


