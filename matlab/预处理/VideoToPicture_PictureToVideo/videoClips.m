function videoClips(save_path, dir_name, frame_num, image_stype )



%%读取文件路径
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end

for i = 1 : length(file_List)
    %% 读取视频
    video_path = file_List{i};
    video = VideoReader(video_path);
    all_name = regexp(video.name, '\.', 'split');
    image_name = all_name{1};
    %% 读取第一帧
    image = read(video, frame_num);         %读出图片
    imwrite(image, strcat(save_path, image_name, '.', image_stype));
end