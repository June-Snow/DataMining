%function videoClips(dir_name, frame_num, image_stype )
%%读取文件路径
clear all;
clc;
dir_name = 'E:\CNN-public-data-sets\StanfordDogsDataset\224X224\';
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
for i = 1 : length(file_List)
    %% 读取视频
    disp(['Now processing image:', num2str(i)]);
    path = file_List{i};
    [pathstr, name, ext] = fileparts(path);
    if strcmp(ext,  '.jpg')
        image = imread(path);         %读出图片
        [M, N, ~] = size(image);
        if M ~= 224 || N ~= 224
            image = imresize(image, [224, 224]);
            imwrite(image, path);
        end
        
    end
    
    
end