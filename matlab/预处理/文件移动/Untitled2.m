%% 
%˵������ȡ�����ļ�����û�й�ͬ���ļ���
%���ܣ���ȡ�����ļ�����û�й�ͬ���ļ���
%������path1,path2ΪԴ�ļ���·���� path3,path4Ϊ�ļ�����·��

path1 = 'I:\WebRoot\��ͬ�ļ����ļ�\';%%Ϊ�ͷֱ���Դ�ļ���·��
path3 = '';%path1�е��ļ���
path2 = 'I:\�㶫3��\��ͬ�ļ����ļ�\';%%Ϊ����Դ�ļ���·��
path4 = '';%path1�е��ļ���
move_path = 'I:\�㶫3��\��ͬ�ļ����ļ���ͬ���ݸ��ļ���\';

low_files = generateFolderTree(path1);
high_files = generateFolderTree(path2);

if isempty(low_files);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len1 = length(low_files);

if isempty(high_files);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
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
      %name1 = name1{1};   %��cell����ת��Ϊstring����
    if i < len
        name2 = file_name{i+1};
        if ~strcmp(name1, name2)
            i = i + 1;
            %low�ļ�����
            path_low = strcat(path1, name1, '\');
            file_List1 = getAllFiles(path_low);
            if ~isempty(file_List1);
                path = strcat(path3, name1,  '\');
                mkdir(path);
                for j = 1 : length(file_List1)
                    file_path1 = file_List1{j};
                    [pathstr, name, ext1] = fileparts(file_path1);
                    source_path = file_path1;%ext1Ϊ.ps
                    save_file_path = strcat(path, name, ext1);%ext1Ϊ.ps
                    if exist(source_path, 'file')
                        movefile(source_path, save_file_path);
                    end
                end
                file_List1 = getAllFiles(path_low);
                if isempty(file_List1);
                    rmdir(path_low);
                end
            end
            %high�ļ�����
            path_high = strcat(path2, name1, '\');
            file_List2 = getAllFiles(path_high);
            if ~isempty(file_List2);
                path = strcat(path4, name1,  '\');
                mkdir(path);
                for j = 1 : length(file_List2)
                    file_path2 = file_List2{j};
                    [pathstr, name, ext1] = fileparts(file_path2);
                    source_path = file_path2;%ext1Ϊ.ps
                    save_file_path = strcat(path, name, ext1);%ext1Ϊ.ps
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


