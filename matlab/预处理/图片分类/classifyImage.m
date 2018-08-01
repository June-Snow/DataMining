%用Matlab 对图像分类
dir_name = 'F:\图片库4.1\test\新建文件夹';

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
save_name = '';
%cd(dir_name);%movefile 工作的当前目录
for i = 1 : length(file_List)
    %% 读取图片
    image_path = file_List{i};
    image = imread(image_path);
    [pathstr, name, ext] = fileparts(image_path);
    clip_name = name(1 : 3);%取名字中的1到4位
    
    if(isempty(save_name))
        mkdir(strcat(pathstr, '\', clip_name));
        save_name = clip_name;
    end
    if(strcmp(save_name, clip_name))
        folder_path = strcat(pathstr, '\', clip_name, '\');
        movefile(image_path, folder_path);
    end
    if(strcmp(save_name, clip_name) == 0)
        mkdir(strcat(pathstr, '\', clip_name));
        folder_path = strcat(pathstr, '\', clip_name, '\');
        movefile(image_path, folder_path);
        save_name = clip_name;
    end
end