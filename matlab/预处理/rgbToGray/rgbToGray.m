function rgbToGray(disk_path, dir_name )
%%��ȡ�ļ�·��
% dir_name = 'F:\��Ƶ����\ͼƬ�ü�';
% disk_path = 'E:';
str = [];
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end

for i = 1 : length(file_List)
    %% ��ȡͼƬ
    image_path = file_List{i};
    image = imread(image_path);
    
    [pathstr, name, ext] = fileparts(image_path);  %�޸Ĵ洢·��
    path_name_split = regexp(pathstr, '\:', 'split');
    path_str = strcat(disk_path, path_name_split{2});
    path_str_rep = strrep(path_str, '\', '/');
    if ~(strcmp(str, pathstr))
        mkdir(path_str_rep);
        str = pathstr;
    end
    
    image = rgb2gray(image);
    imwrite(image, strcat(path_str, '\', name, ext));
end
end
