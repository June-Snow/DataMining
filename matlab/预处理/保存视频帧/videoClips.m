%function videoClips(dir_name, frame_num, image_stype )
%%读取文件路径
clear all;
clc;
frame_num = 3;
image_stype = 'jpg';
dir_name = 'C:\Users\Serissa\Desktop\2016-09-28-15-29-55-tb_leafOcclusion\';
ori_name = '2016-09-28-15-29-55-tb_leafOcclusion';
rep_name = '树叶遮挡图片';

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
for i = 1 : 470
    %% 读取视频
    video_path = file_List{i};
    [pathstr, name, ext] = fileparts(video_path);
    if strcmp(ext,  '.avi')
        try
            video = VideoReader(video_path);
        catch err
            continue;
        end        
        %% 读取第一帧
        for j = 1 : 1%video.NumberOfFrames
            image = read(video, j);         %读出图片
        end
        save_path = strcat(strrep(pathstr, ori_name, rep_name), '\');
        if ~exist(save_path)
         mkdir(save_path);           
        end
        imwrite(image, strcat(save_path, name, '.', image_stype));
    end
end

