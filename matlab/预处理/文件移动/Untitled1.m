%% 
%˵���������ļ��кϲ�
%���ܣ�������ͬ�ļ����µ��ļ���
%������path1ΪԴ�ļ���·���� save_path�ļ�����·��
ath1 = 'E:\WebRoot\��ͬ�ļ����ļ�\';%%Ϊ�ͷֱ���Դ�ļ���·��
path2 = 'E:\�㶫3��\��ͬ�ļ���\';%%Ϊ����Դ�ļ���·��
path3 = 'E:\WebRoot\�ϲ���ͬ�ļ�\';
path4 = 'E:\�㶫3��\�ϲ���ͬ�ļ�\';
save_path1 = 'H:\===����ṩ-��ת��AVI��ʽ��PS���ļ�===\�㶫ʡ����ֹ3�·��ռ�\�ļ��滻\û���ļ����滻��ԭʼ�ļ�\';%û���滻��Դ�ļ�
save_path2 = 'H:\===����ṩ-��ת��AVI��ʽ��PS���ļ�===\�㶫ʡ����ֹ3�·��ռ�\�ļ��滻\�ļ������滻\';%���滻��Դ�ļ�
save_path3 = 'H:\===����ṩ-��ת��AVI��ʽ��PS���ļ�===\�㶫ʡ����ֹ3�·��ռ�\�ļ��滻\�����ļ�\';%û��Դ�ļ�
% file_List1 = getAllFiles(path1);
% if isempty(file_List1);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len1 = length(file_List1);
% for i = 1 : len1
%     file_path1 = file_List1{i};
%     [pathstr, name1, ext1] = fileparts(file_path1);
%     source_path = file_path1;%ext1Ϊ.ps
%     save_file_path = strcat(path3, name1, ext1);%ext1Ϊ.ps
%     if exist(source_path, 'file')
%         movefile(source_path, save_file_path);
%     end
% end
% 
% file_List2 = getAllFiles(path2);
% if isempty(file_List2);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len2 = length(file_List2);
% for i = 1 : len2
%     file_path2 = file_List2{i};
%     [pathstr, name2, ext2] = fileparts(file_path2);
%     source_path = file_path2;%ext1Ϊ.ps
%     save_file_path = strcat(path4, name2, ext2);%ext1Ϊ.ps
%     if exist(source_path, 'file')
%         movefile(source_path, save_file_path);
%     end
% end

file_List1 = getAllFiles(path3);
if isempty(file_List1);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len1 = length(file_List1);

file_List2 = getAllFiles(path4);
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
            source_path = strcat(path3, name1, '.avi');
            save_file_path = strcat(save_path1, name1, '.avi');%ext1Ϊ.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
            source_path = strcat(path4, name1, '.avi');
            save_file_path = strcat(save_path3, name1, '.avi');%ext1Ϊ.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
        else
            i = i +2;
            
            source_path = strcat(path4, name1, '.avi');%ext1Ϊ.ps
            save_file_path = strcat(save_path2, name1, '.avi');%ext1Ϊ.ps
            if exist(source_path, 'file')
                movefile(source_path, save_file_path);
            end
            %
            source_path = strcat(path3, name1, '.avi');%ext1Ϊ.ps
            save_file_path = strcat(save_path2, name1,'low', '.avi');%ext1Ϊ.ps
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



