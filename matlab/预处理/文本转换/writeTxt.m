clear all;
clc;
fid = fopen('C:\Users\Serissa\Desktop\�½��ļ���\�����.txt', 'w');
dir_name = 'C:\Users\Serissa\Desktop\�����\';
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(file_List);
for i=1 : len
    video_path = file_List{i};
    [pathstr, name, ext] = fileparts(video_path);
    fprintf(fid, '%s\r\n', name);
end