%%
%˵������psԴ�ļ�ת����avi�ļ���ת���ɹ���avi�ļ�������avi�ļ����У�psΪԴ�ļ���
%���ܣ���û��ת���ɹ���ps�ļ���Դps�ļ��и��Ƶ�avi�ļ���
%������path1ΪpsԴ�ļ���·����path2Ϊavi�ļ���·��

clear all;
clc;
path1 = 'I:\20160327(11218)_AVI\ps�ļ�\';%%ps�ļ�
file_List1 = getAllFiles(path1);
if isempty(file_List1);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len1 = length(file_List1);

path2 = 'I:\20160327(11218)\';%%avi�ļ�
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
path2 = strcat(path2, '\ps�ļ�\');
mkdir(path2);
while(i <= len)
      name1 = file_name(i);
      name1 = name1{1};   %��cell����ת��Ϊstring����
    if i < len
        name2 = file_name(i+1);
        name2 = name2{1};
        if ~strcmp(name1, name2)
            i = i + 1;
%             source_path = strcat(path1, name1, ext1);%ext1Ϊ.ps
%             save_path = strcat(path2, name1, ext1);%ext1Ϊ.ps
%             if exist(source_path, 'file')
%                 copyfile(source_path, save_path);
%                 %movefile();
%             end
        else
            i = i +2;
            source_path = strcat(path1, name1, ext1);%ext1Ϊ.ps
            save_path = strcat(path2, name1, ext1);%ext1Ϊ.ps
            if exist(source_path, 'file')
               %copyfile(source_path, save_path);
               movefile(source_path, save_path);
            end
        end
    else
%         source_path = strcat(path1, name1, ext1);%ext1Ϊ.ps
%         save_path = strcat(path2, name1, ext1);%ext1Ϊ.ps
%         if exist(source_path, 'file')
%             copyfile(source_path, save_path);
%             %movefile();
%         end
%         break;
    end
end


%%ͬһ�ļ����ҳ��������ļ�����ͬ����׺��ͬ���ļ�
% i = 1;
% while(i <= len)
%       path = name{i};
%     [pathstr, name, ext] = fileparts(path); 
%     if i < len
%         path1 = file_List{i+1};
%         [pathstr1, name1, ext1] = fileparts(path1);
%         if ~strcmp(name, name1)
%             i = i + 1;
%             path = strcat(save_path, '\', name, ext );
%             if exist(path, 'file')
%                 copyfile(path1, path);
%                 %movefile();
%             end
%         else
%             i = i +2;
%         end        
%     end
% end