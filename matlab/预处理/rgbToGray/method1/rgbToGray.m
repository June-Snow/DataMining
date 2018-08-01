function rgbToGray(save_file_name, dir_name )
%%��ȡ�ļ�·��
str = [];
len = length(dir_name);

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end

for i = 1 : length(file_List)
    %% ��ȡͼƬ
    image_path = file_List{i};
    image = imread(image_path);

    [pathstr, name, ext] = fileparts(image_path);
    
%     path_name_split = regexp(pathstr, '\:', 'split');%�޸Ĵ洢·��
%     path_regexp = regexp(path_name_split{2}, '\\', 'split');
%     len = length(path_regexp);
    
%     path_str = strcat(save_path, path_name_split{2});
    path_str_rep = strrep(pathstr, '\', '/');
    path_str_rep(len) = 'save_file_name';
    
    if ~(strcmp(str, pathstr))
        mkdir(path_str_rep);
        str = pathstr;
    end
    
    image = rgb2gray(image);
    imwrite(image, strcat(path_str, '\', name, ext));
end
end
