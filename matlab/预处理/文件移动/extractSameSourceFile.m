%% 
%˵���������ļ����ļ�����(2)���ļ����е�������ļ�����
%���ܣ����ļ�����Ӧ���ļ��������е�������ļ�����
%������path1ΪԴ�ļ���·��
clear all;
clc;

path1 = 'I:\WebRoot\Դ�ļ�\';%%ps�ļ�'
path3 = 'I:\WebRoot\��ͬ�ļ����ļ�\';%����·��
file_List1 = getAllFiles(path1);
if isempty(file_List1);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
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
    name1 = name1{1};   %��cell����ת��Ϊstring����
    if i < len
        name2 = file_name(i+1);
        name2 = name2{1};
        idx=strfind(name2,'(');
        if idx
            path2 = strcat(path3, name1, '\');
            mkdir(path2);
            source_path = strcat(path1, name1, ext1);%ext1Ϊ.ps
            save_path = strcat(path2, name1, ext1);%ext1Ϊ.ps
            movefile(source_path, save_path);
        else
            i = i + 1;
        end
        while idx            
            name2 = file_name(i+1);
            name2 = name2{1};
            idx=strfind(name2,'(');
            if idx               
                source_path = strcat(path1, name2, ext1);%ext1Ϊ.ps
                save_path = strcat(path2, name2, ext1);%ext1Ϊ.ps
                movefile(source_path, save_path);
            end
             i = i +1;
        end
    else
        break;
    end
end




