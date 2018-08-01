%% 
%说明：找出两个文件夹中相同文件
%功能：把两个文件夹中相同文件名的剪切到一个文件夹下的两个文件夹中
%参数：path1为源文件夹路径，path2为高清源文件夹路径， save_path文件保存路径

clear all;
clc;
path1 = 'H:\WebRoot\不同文件名文件\';%%为低分辨率源文件夹路径
path2 = 'I:\===李军提供-待转换AVI格式的PS流文件===\广东省厅截止3月份收集\不同文件名文件\';%%为高清源文件夹路径
save_path = 'I:\===李军提供-待转换AVI格式的PS流文件===\广东省厅截止3月份收集\两个不同文件中的相同文件\';%文件保存路径

path_low = strcat(save_path, 'low\');
mkdir(path_low);
path_high = strcat(save_path, 'high\');
mkdir(path_high);

file_List1 = getAllFiles(path1);
if isempty(file_List1);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len1 = length(file_List1);

file_List2 = getAllFiles(path2);
if isempty(file_List2);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len2 = length(file_List2);
str_name = cell(len1+len2,1);

for i = 1 : len1
    file_path1 = file_List1{i};
    [pathstr, name1, ext1] = fileparts(file_path1);
    str_name(i) = {name1};
end
for i = 1 : len2
    file_path2 = file_List2{i};
    [pathstr, name2, ext2] = fileparts(file_path2);
    str_name(i+len1) = {name2};    
end

file_name = sortrows(str_name);
len = length(file_name);
i = 1;
while(i <= len)
      name1 = file_name(i);
      name1 = name1{1};   %将cell类型转换为string类型
    if i < len
        name2 = file_name(i+1);
        name2 = name2{1};
        if ~strcmp(name1, name2)
            i = i + 1;
        else
            i = i +2;
            %移动低分辨率文件
            source_path = strcat(path1, name1, ext1);%ext1为.ps
            save_file_path = strcat(path_low, name1, ext1);%ext1为.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
            %移动高分辨率文件
            source_path = strcat(path2, name2, ext2);%ext1为.ps
            save_file_path = strcat(path_high, name2, ext2);%ext1为.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
        end
    else
         break;
    end
end





