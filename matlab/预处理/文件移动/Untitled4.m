path1 = 'H:\===����ṩ-��ת��AVI��ʽ��PS���ļ�===\�㶫ʡ����ֹ3�·��ռ�\�ļ��滻\�ļ������滻\�滻�ļ�\';
move_path = 'H:\===����ṩ-��ת��AVI��ʽ��PS���ļ�===\�㶫ʡ����ֹ3�·��ռ�\�ļ��滻\�ļ������滻\ԭʼ�ļ�\';
file_List1 = getAllFiles(path1);
if isempty(file_List1);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len1 = length(file_List1);

for i = 1 : len1
    file_path1 = file_List1{i};
    [pathstr, name1, ext1] = fileparts(file_path1);
    if strfind(name1,'low')
        source_path = file_path1;%ext1Ϊ.ps
        save_file_path = strcat(move_path, name1, ext1);%ext1Ϊ.ps
        if exist(source_path, 'file')
            movefile(source_path, save_file_path);
        end
%     else
%         source_path = file_path1;%ext1Ϊ.ps
%         save_file_path = strcat(move_path, name1,'low', ext1);%ext1Ϊ.ps
%         if exist(source_path, 'file')
%             movefile(source_path, save_file_path);
%         end
    end
end