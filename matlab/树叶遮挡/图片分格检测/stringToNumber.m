function stringToNumber(save_path, source_path)
%% ���ַ����е�1ת���ɶ�Ӧ����ţ����������ʽ�洢��txt�ļ���
% file_r = fopen('F:\�оֵڶ�������ͼƬ����\��Ҷ�ڵ�.txt', 'r');
% file_w = fopen('F:\�оֵڶ�������ͼƬ����\��Ҷ����.txt', 'w');
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


