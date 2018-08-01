clear all; 
close all; %播放程序  
WID = 1280;
HEI = 720;
save_path = 'E:\视频库 5.0\Database\SURDB0.3\train\';
dir_name = 'E:\视频库 5.0\Database\SURDB0.3\train\正常视频\';

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end

for i = 1 : length(file_List)
    %% 读取视频
    video_path = file_List{i};
    [pathstr, name, ext] = fileparts(video_path);
    if strcmp(ext,  '.avi')
        videoResult = VideoReader(video_path);
        videoWidth = videoResult.Width;
        videoHeight = videoResult.Height;
        if videoWidth ~= WID || videoHeight ~= HEI
            aviobj = VideoWriter(strcat(save_path, name, '.avi'));
            aviobj.FrameRate = 10;
            open(aviobj);
            nFramesResult = videoResult.NumberOfFrames; %帧数           
            for j = 1: nFramesResult-2
                ColorImg = read(videoResult, j);
                ColorImg = imresize(ColorImg, [HEI, WID]);
                writeVideo(aviobj, ColorImg);
            end
            close(aviobj);
        end
        if videoWidth < WID || videoHeight < HEI
            copyfile(video_path, save_path);
        end
    end
end
