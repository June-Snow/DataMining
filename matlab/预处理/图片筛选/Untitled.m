dir_name = 'C:\Users\Serissa\Desktop\树叶遮挡图片\';
save_path = 'C:\Users\Serissa\Desktop\异常图片\';
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end

for i = 1 : length(file_List)
    %%读取视频
    img_path = file_List{i};
    figure;imshow(img_path);
    [pathstr, name, ext] = fileparts(img_path);
    x = input('s');
    if x == 0
        path = strcat(save_path, name, ext); 
        movefile(img_path, path);
    end
    close all;
end