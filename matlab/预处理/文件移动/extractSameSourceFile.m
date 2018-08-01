%% 
%说明：把有文件和文件副本(2)的文件剪切到另外的文件夹中
%功能：把文件和相应的文件副本剪切到另外的文件夹中
%参数：path1为源文件夹路径
clear all;
clc;

path1 = 'I:\WebRoot\源文件\';%%ps文件'
path3 = 'I:\WebRoot\相同文件名文件\';%保存路径
file_List1 = getAllFiles(path1);
if isempty(file_List1);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len1 = length(file_List1);
str_name = cell(len1,1);
for i = 1 : len1
    file_path1 = file_List1{i};
    [pathstr, name1, ext1] = fileparts(file_path1);
    str_name(i) = {name1};
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
        idx=strfind(name2,'(');
        if idx
            path2 = strcat(path3, name1, '\');
            mkdir(path2);
            source_path = strcat(path1, name1, ext1);%ext1为.ps
            save_path = strcat(path2, name1, ext1);%ext1为.ps
            movefile(source_path, save_path);
        else
            i = i + 1;
        end
        while idx            
            name2 = file_name(i+1);
            name2 = name2{1};
            idx=strfind(name2,'(');
            if idx               
                source_path = strcat(path1, name2, ext1);%ext1为.ps
                save_path = strcat(path2, name2, ext1);%ext1为.ps
                movefile(source_path, save_path);
            end
             i = i +1;
        end
    else
        break;
    end
end




