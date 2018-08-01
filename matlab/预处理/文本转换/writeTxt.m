clear all;
clc;
fid = fopen('C:\Users\Serissa\Desktop\新建文件夹\误分类.txt', 'w');
dir_name = 'C:\Users\Serissa\Desktop\误分类\';
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len = length(file_List);
for i=1 : len
    video_path = file_List{i};
    [pathstr, name, ext] = fileparts(video_path);
    fprintf(fid, '%s\r\n', name);
end