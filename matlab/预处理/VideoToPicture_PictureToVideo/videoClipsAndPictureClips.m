function videoClipsAndPictureClips(disk_path, dir_name, image_width, image_height, stride, image_stype )
%%读取文件路径
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
    
    path_name_split = regexp(video.path,'\:','split');%修改存储路径
    path_str = strcat(disk_path, path_name_split{2});
    path_str_rep = strrep(path_str,'\','/');
    
    if ~(strcmp(str,video.path))
        mkdir(path_str_rep);
        str = video.path;
    end
    
    % save_path = strcat(path_str, '\', num2str(dirct_name));
    save_path = strcat(path_str, '\', video_name);
    %% 读取第一帧
    image = read(video, 1);         %读出图片
     imwrite(image, strcat(save_path,  '.bmp'));
    %im2block(image, save_path, image_width, image_height, image_stype);
    
    %%pictureClips
    
%     blk_size_width = image_width;
%     blk_size_height = image_height;
%     [M N K] = size(image);
%     
%     for r = blk_size_width/2+1 : stride : M-blk_size_width/2
%         for c = blk_size_height/2+1 : stride : N-blk_size_height/2
%             blk = image(r-blk_size_width/2 : r+blk_size_width/2-1, c-blk_size_height/2 : c+blk_size_height/2-1, : );
%             
%             imwrite(blk, strcat( save_path, num2str(r), num2str(c), '.', image_stype));
%         end
%     end
end
end



