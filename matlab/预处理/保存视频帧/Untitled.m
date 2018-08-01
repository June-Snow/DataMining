%function videoClips(dir_name, frame_num, image_stype )
%%��ȡ�ļ�·��
clear all;
clc;
dir_name = 'E:\CNN-public-data-sets\StanfordDogsDataset\224X224\';
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
for i = 1 : length(file_List)
    %% ��ȡ��Ƶ
    path = file_List{i};
    [pathstr, name, ext] = fileparts(path);
    if strcmp(ext,  '.jpg')
        image = imread(path);         %����ͼƬ
    
        imwrite(image, strcat(save_path, name, '.', image_stype));
    end
    
    
end