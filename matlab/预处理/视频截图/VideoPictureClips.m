%% ��ȡ�ļ�·��
dir_name = 'F:\��Ƶ��\��Ƶ�� 4.1\1000 �����ܼ�\1000_0008';
file_List = getAllFiles(dir_name);
str = [];
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end

for i = 1 : length(file_List)
    %% ��ȡ��Ƶ
    video_path = file_List{i};
    video = VideoReader(video_path);
    
    %%����Ƶ�����ԡ�.���ֳ������֣�ǰһ�������֣���һ������avi��׺
    split_name = regexp(video.name, '\.' , 'split');
    video_name = split_name{1};
    %dirct_name = num2str(video_name);
    
    %�޸Ĵ洢·��
%     path_name_split = regexp(video.path,'\:','split');
%     path_str = strcat(disk_path, path_name_split{2});
%     path_str_rep = strrep(path_str,'\','/');
%     if ~(strcmp(str,video.path))
%         mkdir(path_str_rep);
%         str = video.path;
%     end
    
    % save_path = strcat(path_str, '\', num2str(dirct_name));
    %save_path = strcat(path_str, '\', video_name);
    %% ��ȡ��һ֡
    image = read(video, 1);         %����ͼƬ
    batCrop(image, video_name)
     %imwrite(image, strcat(save_path,  '.bmp'));
end