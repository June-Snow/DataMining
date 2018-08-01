%function videoClips(dir_name, frame_num, image_stype )
%%读取文件路径
clear all;
clc;
frame_num = 1;
image_stype = 'jpg';
replace_name = '树叶遮挡图片';
dir_name = 'F:\litao\树叶遮挡';
%videoClips(dir_name, num, stype);

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end

for i = 1 : length(file_List)
    %% 读取视频
    video_path = file_List{i};
    [pathstr, name, ext] = fileparts(video_path);
    if strcmp(ext,  '.avi')
        video = VideoReader(video_path);
        all_name = regexp(video.name, '\.', 'split');
        image_name = all_name{1};
        save_path = strrep(video.Path,'树叶遮挡',replace_name);
        dir_path = strrep(save_path, '\', '/');
        %% 读取第一帧
        for j = 1 : 1%video.NumberOfFrames
            image = read(video, j);         %读出图片
%             figure;
%             imshow(image);
        end
        if ~isdir(dir_path)
            mkdir(dir_path);
        end
        %         mkdir(dir_path);
                 imwrite(image, strcat(dir_path,'\', image_name, '.', image_stype));
    end
end

