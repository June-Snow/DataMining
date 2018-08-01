clear all; 
close all; %���ų���  
save_path = 'F:\github\Matlab\�����ڵ�\��Ƶ\�½��ļ���\';
dir_name = 'F:\github\Matlab\�����ڵ�\��Ƶ\�ڵ�';
picture_path = 'F:\github\Matlab\�����ڵ�\��Ƶ\ͼƬ\';

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end

picture_list = getAllFiles(picture_path);

for i = 1 : length(file_List)
    %% ��ȡ��Ƶ
    video_path = file_List{i};
    [pathstr, name, ext] = fileparts(video_path);
    
    pic_path = picture_list{i};
    [pic_pathstr, pic_name, pic_ext] = fileparts(pic_path);
    
    if strcmp(pic_ext, '.jpg')
        img = imread(pic_path);
    end
    
    if strcmp(ext,  '.avi')
        videoResult = VideoReader(video_path);
        nFramesResult = videoResult.NumberOfFrames; %֡��
        % Preallocate movie structure.
        aviobj = VideoWriter(strcat(save_path, name, '.avi'));
        aviobj.FrameRate = 10;
        open(aviobj);
        
        start = fix(300*rand(1));
        ending = fix(120*rand(1)) + start + 288;
        for j = 1: nFramesResult - 1
            if j > 20
                break;
            end
            ColorImg = read(videoResult, j);
            %GrayImg = rgb2gray(ColorImg);
            if j > 7                               
                for k = start : ending
                    ColorImg(k, :, :) = img(k, :, :);
                end
            end
            writeVideo(aviobj, ColorImg);
        end
        close(aviobj);
    end
end







