function videoClipsAndPictureClips(disk_path, dir_name, image_width, image_height, stride, image_stype )
%%��ȡ�ļ�·��
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
    
    path_name_split = regexp(video.path,'\:','split');%�޸Ĵ洢·��
    path_str = strcat(disk_path, path_name_split{2});
    path_str_rep = strrep(path_str,'\','/');
    
    if ~(strcmp(str,video.path))
        mkdir(path_str_rep);
        str = video.path;
    end
    
    % save_path = strcat(path_str, '\', num2str(dirct_name));
    save_path = strcat(path_str, '\', video_name);
    %% ��ȡ��һ֡
    image = read(video, 1);         %����ͼƬ
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



