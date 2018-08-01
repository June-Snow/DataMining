clear all; 
close all; %���ų���  
WID = 1280;
HEI = 720;
save_path = 'E:\��Ƶ�� 5.0\Database\SURDB0.3\train\';
dir_name = 'E:\��Ƶ�� 5.0\Database\SURDB0.3\train\������Ƶ\';

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end

for i = 1 : length(file_List)
    %% ��ȡ��Ƶ
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
            nFramesResult = videoResult.NumberOfFrames; %֡��           
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
