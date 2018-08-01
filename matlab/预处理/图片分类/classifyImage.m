%��Matlab ��ͼ�����
dir_name = 'F:\ͼƬ��4.1\test\�½��ļ���';

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
save_name = '';
%cd(dir_name);%movefile �����ĵ�ǰĿ¼
for i = 1 : length(file_List)
    %% ��ȡͼƬ
    image_path = file_List{i};
    image = imread(image_path);
    [pathstr, name, ext] = fileparts(image_path);
    clip_name = name(1 : 3);%ȡ�����е�1��4λ
    
    if(isempty(save_name))
        mkdir(strcat(pathstr, '\', clip_name));
        save_name = clip_name;
    end
    if(strcmp(save_name, clip_name))
        folder_path = strcat(pathstr, '\', clip_name, '\');
        movefile(image_path, folder_path);
    end
    if(strcmp(save_name, clip_name) == 0)
        mkdir(strcat(pathstr, '\', clip_name));
        folder_path = strcat(pathstr, '\', clip_name, '\');
        movefile(image_path, folder_path);
        save_name = clip_name;
    end
end