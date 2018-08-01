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
    disp(['Now processing image:', num2str(i)]);
    path = file_List{i};
    [pathstr, name, ext] = fileparts(path);
    if strcmp(ext,  '.jpg')
        image = imread(path);         %����ͼƬ
        [M, N, ~] = size(image);
        if M ~= 224 || N ~= 224
            image = imresize(image, [224, 224]);
            imwrite(image, path);
        end
        
    end
    
    
end