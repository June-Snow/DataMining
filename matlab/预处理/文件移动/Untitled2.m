%% 
%说明：提取两个文件夹中没有共同的文件夹
%功能：提取两个文件夹中没有共同的文件夹
%参数：path1,path2为源文件夹路径， path3,path4为文件保存路径

path1 = 'I:\WebRoot\相同文件名文件\';%%为低分辨率源文件夹路径
path3 = '';%path1中的文件夹
path2 = 'I:\广东3月\相同文件名文件\';%%为高清源文件夹路径
path4 = '';%path1中的文件夹
move_path = 'I:\广东3月\相同文件名文件相同内容改文件名\';

low_files = generateFolderTree(path1);
high_files = generateFolderTree(path2);

if isempty(low_files);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len1 = length(low_files);

if isempty(high_files);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len2 = length(high_files);
str_name = cell(len1+len2,1);

for i = 1 : len1
    path = low_files{i};
    index = strfind(path, '\');
    str_name{i} = path(index(end)+1: end);
end
for i = 1 : len2
    path = high_files{i};
    index = strfind(path, '\');
    str_name{i+len1} = path(index(end)+1: end);   
end

file_name = sortrows(str_name);
len = length(file_name);
i = 1;
while(i <= len)
      name1 = file_name{i};
      %name1 = name1{1};   %将cell类型转换为string类型
    if i < len
        name2 = file_name{i+1};
        if ~strcmp(name1, name2)
            i = i + 1;
            %low文件夹中
            path_low = strcat(path1, name1, '\');
            file_List1 = getAllFiles(path_low);
            if ~isempty(file_List1);
                path = strcat(path3, name1,  '\');
                mkdir(path);
                for j = 1 : length(file_List1)
                    file_path1 = file_List1{j};
                    [pathstr, name, ext1] = fileparts(file_path1);
                    source_path = file_path1;%ext1为.ps
                    save_file_path = strcat(path, name, ext1);%ext1为.ps
                    if exist(source_path, 'file')
                        movefile(source_path, save_file_path);
                    end
                end
                file_List1 = getAllFiles(path_low);
                if isempty(file_List1);
                    rmdir(path_low);
                end
            end
            %high文件夹中
            path_high = strcat(path2, name1, '\');
            file_List2 = getAllFiles(path_high);
            if ~isempty(file_List2);
                path = strcat(path4, name1,  '\');
                mkdir(path);
                for j = 1 : length(file_List2)
                    file_path2 = file_List2{j};
                    [pathstr, name, ext1] = fileparts(file_path2);
                    source_path = file_path2;%ext1为.ps
                    save_file_path = strcat(path, name, ext1);%ext1为.ps
                    if exist(source_path, 'file')
                        movefile(source_path, save_file_path);
                    end                    
                end
                file_List2 = getAllFiles(path_high);
                if isempty(file_List2);
                    rmdir(path_high);
                end
            end
        else
            i = i +2;
        end
    else
         break;
    end
end


