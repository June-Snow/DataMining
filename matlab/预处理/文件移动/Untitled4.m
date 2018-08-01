path1 = 'H:\===李军提供-待转换AVI格式的PS流文件===\广东省厅截止3月份收集\文件替换\文件重名替换\替换文件\';
move_path = 'H:\===李军提供-待转换AVI格式的PS流文件===\广东省厅截止3月份收集\文件替换\文件重名替换\原始文件\';
file_List1 = getAllFiles(path1);
if isempty(file_List1);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len1 = length(file_List1);

for i = 1 : len1
    file_path1 = file_List1{i};
    [pathstr, name1, ext1] = fileparts(file_path1);
    if strfind(name1,'low')
        source_path = file_path1;%ext1为.ps
        save_file_path = strcat(move_path, name1, ext1);%ext1为.ps
        if exist(source_path, 'file')
            movefile(source_path, save_file_path);
        end
%     else
%         source_path = file_path1;%ext1为.ps
%         save_file_path = strcat(move_path, name1,'low', ext1);%ext1为.ps
%         if exist(source_path, 'file')
%             movefile(source_path, save_file_path);
%         end
    end
end