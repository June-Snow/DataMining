function numberSort(txt_path, swave_txt_path)
%% 把字符串进行排序，输出字符串和它出现的次数

fileID = fopen(txt_path, 'r');
fax = textscan(fileID,'%s');
fclose(fileID);
num = fax{1};
num = sort(num);
sum = 1;
%fid = fopen(strcat('F:\日常工作\树叶遮挡\正常图片排序结果', '.txt'), 'w');
fid = fopen(swave_txt_path, 'w');
for i = 2: length(num)
    if (char(num(i - 1)) == char(num(i)));
        sum = sum + 1;
    else
        fprintf(fid,'%s %d\t',char(num(i - 1)), sum);
        sum = 1;
    end
end

    fprintf(fid,'%s %d\t',char(num(length(num))),sum);
    fclose(fid);

end
