%% 
%说明：两个文件夹合并
%功能：更改相同文件夹下的文件名
%参数：path1为源文件夹路径， save_path文件保存路径
ath1 = 'E:\WebRoot\相同文件名文件\';%%为低分辨率源文件夹路径
path2 = 'E:\广东3月\相同文件名\';%%为高清源文件夹路径
path3 = 'E:\WebRoot\合并相同文件\';
path4 = 'E:\广东3月\合并相同文件\';
save_path1 = 'H:\===李军提供-待转换AVI格式的PS流文件===\广东省厅截止3月份收集\文件替换\没有文件可替换的原始文件\';%没有替换的源文件
save_path2 = 'H:\===李军提供-待转换AVI格式的PS流文件===\广东省厅截止3月份收集\文件替换\文件重名替换\';%有替换的源文件
save_path3 = 'H:\===李军提供-待转换AVI格式的PS流文件===\广东省厅截止3月份收集\文件替换\新增文件\';%没有源文件
% file_List1 = getAllFiles(path1);
% if isempty(file_List1);
%     error('设定的文件夹内没有任何视频，请重新检查...')
% end
% len1 = length(file_List1);
% for i = 1 : len1
%     file_path1 = file_List1{i};
%     [pathstr, name1, ext1] = fileparts(file_path1);
%     source_path = file_path1;%ext1为.ps
%     save_file_path = strcat(path3, name1, ext1);%ext1为.ps
%     if exist(source_path, 'file')
%         movefile(source_path, save_file_path);
%     end
% end
% 
% file_List2 = getAllFiles(path2);
% if isempty(file_List2);
%     error('设定的文件夹内没有任何视频，请重新检查...')
% end
% len2 = length(file_List2);
% for i = 1 : len2
%     file_path2 = file_List2{i};
%     [pathstr, name2, ext2] = fileparts(file_path2);
%     source_path = file_path2;%ext1为.ps
%     save_file_path = strcat(path4, name2, ext2);%ext1为.ps
%     if exist(source_path, 'file')
%         movefile(source_path, save_file_path);
%     end
% end

file_List1 = getAllFiles(path3);
if isempty(file_List1);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len1 = length(file_List1);

file_List2 = getAllFiles(path4);
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
            source_path = strcat(path3, name1, '.avi');
            save_file_path = strcat(save_path1, name1, '.avi');%ext1为.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
            source_path = strcat(path4, name1, '.avi');
            save_file_path = strcat(save_path3, name1, '.avi');%ext1为.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
        else
            i = i +2;
            
            source_path = strcat(path4, name1, '.avi');%ext1为.ps
            save_file_path = strcat(save_path2, name1, '.avi');%ext1为.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
            %
            source_path = strcat(path3, name1, '.avi');%ext1为.ps
            save_file_path = strcat(save_path2, name1,'low', '.avi');%ext1为.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
        end
    end
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



