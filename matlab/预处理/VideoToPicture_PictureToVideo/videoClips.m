function videoClips(save_path, dir_name, frame_num, image_stype )



%%��ȡ�ļ�·��
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end

for i = 1 : length(file_List)
    %% ��ȡ��Ƶ
    video_path = file_List{i};
    video = VideoReader(video_path);
    all_name = regexp(video.name, '\.', 'split');
    image_name = all_name{1};
    %% ��ȡ��һ֡
    image = read(video, frame_num);         %����ͼƬ
    imwrite(image, strcat(save_path, image_name, '.', image_stype));
end