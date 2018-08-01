%function videoClips(dir_name, frame_num, image_stype )
%%��ȡ�ļ�·��
clear all;
clc;
frame_num = 3;
image_stype = 'jpg';
dir_name = 'C:\Users\Serissa\Desktop\2016-09-28-15-29-55-tb_leafOcclusion\';
ori_name = '2016-09-28-15-29-55-tb_leafOcclusion';
rep_name = '��Ҷ�ڵ�ͼƬ';

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
for i = 1 : 470
    %% ��ȡ��Ƶ
    video_path = file_List{i};
    [pathstr, name, ext] = fileparts(video_path);
    if strcmp(ext,  '.avi')
        try
            video = VideoReader(video_path);
        catch err
            continue;
        end        
        %% ��ȡ��һ֡
        for j = 1 : 1%video.NumberOfFrames
            image = read(video, j);         %����ͼƬ
        end
        save_path = strcat(strrep(pathstr, ori_name, rep_name), '\');
        if ~exist(save_path)
         mkdir(save_path);           
        end
        imwrite(image, strcat(save_path, name, '.', image_stype));
    end
end

