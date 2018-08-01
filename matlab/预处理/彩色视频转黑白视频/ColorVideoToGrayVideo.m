clear all; 
close all; %播放程序  
save_path = 'F:\github\Matlab\异物遮挡\视频\新建文件夹\';
dir_name = 'F:\github\Matlab\异物遮挡\视频\遮挡';
picture_path = 'F:\github\Matlab\异物遮挡\视频\图片\';

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end

picture_list = getAllFiles(picture_path);

for i = 1 : length(file_List)
    %% 读取视频
    video_path = file_List{i};
    [pathstr, name, ext] = fileparts(video_path);
    
    pic_path = picture_list{i};
    [pic_pathstr, pic_name, pic_ext] = fileparts(pic_path);
    
    if strcmp(pic_ext, '.jpg')
        img = imread(pic_path);
    end
    
    if strcmp(ext,  '.avi')
        videoResult = VideoReader(video_path);
        nFramesResult = videoResult.NumberOfFrames; %帧数
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







