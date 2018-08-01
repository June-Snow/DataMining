%% 读取文件路径
dir_name = 'F:\视频库\视频库 4.1\1000 正常总集\1000_0008';
file_List = getAllFiles(dir_name);
str = [];
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end

for i = 1 : length(file_List)
    %% 读取视频
    video_path = file_List{i};
    video = VideoReader(video_path);
    
    %%把视频名字以‘.’分成两部分，前一部分名字，后一部分是avi后缀
    split_name = regexp(video.name, '\.' , 'split');
    video_name = split_name{1};
    %dirct_name = num2str(video_name);
    
    %修改存储路径
%     path_name_split = regexp(video.path,'\:','split');
%     path_str = strcat(disk_path, path_name_split{2});
%     path_str_rep = strrep(path_str,'\','/');
%     if ~(strcmp(str,video.path))
%         mkdir(path_str_rep);
%         str = video.path;
%     end
    
    % save_path = strcat(path_str, '\', num2str(dirct_name));
    %save_path = strcat(path_str, '\', video_name);
    %% 读取第一帧
    image = read(video, 1);         %读出图片
    batCrop(image, video_name)
     %imwrite(image, strcat(save_path,  '.bmp'));
end