% root = 'F:\视频测试\视频库 4.1';
% save_file_name = '第一帧';
% video_type = 'avi';
% image_type = 'bmp';
% flame_num = 1;
function videoClips(root,save_file_name, video_type, image_type, flame_num)
path_regexp = regexp(root, '\\', 'split');
len = length(path_regexp);
replace_name = path_regexp{len};
path = {};

path_str = generateFolderTree( root);

for i = 1 : length(path_str)
    path_name = dir(strcat(path_str{i}, '\', '*.', video_type));
    
    save_path = strrep(path_str{i}, replace_name, save_file_name);
    mkdir_path = strrep(save_path, '\', '/');
    mkdir(mkdir_path);
    
    for j = 1 : length(path_name)
        video_path = strcat(path_str{i}, '\', path_name(j).name);
        video = VideoReader(video_path);
        all_name = regexp(video.name, '\.', 'split');
        image_name = all_name{1};
        %% 读取第flame_num帧
        image = read(video, flame_num);         %读出图片
        path{j} = strcat(save_path,'\', image_name, '.', image_type);
        imwrite(image, strcat(save_path,'\', image_name, '.', image_type));
        
    end
    txtname = save_path;%,num2str(i)];
    cellwtxt(txtname,path);
end
end
