%% 
%˵�����ҳ������ļ�������ͬ�ļ�
%���ܣ��������ļ�������ͬ�ļ����ļ��е�һ���ļ����µ������ļ�����
%������path1ΪԴ�ļ���·����path2Ϊ����Դ�ļ���·���� save_path�ļ�����·��

clear all;
clc;
path1 = 'H:\WebRoot\��ͬ�ļ����ļ�\';%%Ϊ�ͷֱ���Դ�ļ���·��
path2 = 'I:\===����ṩ-��ת��AVI��ʽ��PS���ļ�===\�㶫ʡ����ֹ3�·��ռ�\��ͬ�ļ����ļ�\';%%Ϊ����Դ�ļ���·��
save_path = 'I:\===����ṩ-��ת��AVI��ʽ��PS���ļ�===\�㶫ʡ����ֹ3�·��ռ�\������ͬ�ļ��е���ͬ�ļ�\';%�ļ�����·��

path_low = strcat(save_path, 'low\');
mkdir(path_low);
path_high = strcat(save_path, 'high\');
mkdir(path_high);

file_List1 = getAllFiles(path1);
if isempty(file_List1);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len1 = length(file_List1);

file_List2 = getAllFiles(path2);
if isempty(file_List2);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
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
      name1 = name1{1};   %��cell����ת��Ϊstring����
    if i < len
        name2 = file_name(i+1);
        name2 = name2{1};
        if ~strcmp(name1, name2)
            i = i + 1;
        else
            i = i +2;
            %�ƶ��ͷֱ����ļ�
            source_path = strcat(path1, name1, ext1);%ext1Ϊ.ps
            save_file_path = strcat(path_low, name1, ext1);%ext1Ϊ.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
            %�ƶ��߷ֱ����ļ�
            source_path = strcat(path2, name2, ext2);%ext1Ϊ.ps
            save_file_path = strcat(path_high, name2, ext2);%ext1Ϊ.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
        end
    else
         break;
    end
end





