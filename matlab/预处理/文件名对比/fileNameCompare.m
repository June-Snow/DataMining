clear all;
clc;
fid = fopen('C:\Users\Serissa\Desktop\�����txt\�����ڵ�.txt', 'w');
dir_name1 = 'H:\litao\�����ڵ�\';
dir_name2 = 'C:\Users\Serissa\Desktop\�����\';

file_List1 = getAllFiles(dir_name1);
if isempty(file_List1);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len1 = length(file_List1);

file_List2 = getAllFiles(dir_name2);
if isempty(file_List2);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len2 = length(file_List2);
file_name = cell(len1+len2, 1);
for i=1 : len1
    video_path = file_List1{i};
    [pathstr, name, ext] = fileparts(video_path);
    file_name{i, 1} =name;
end
for i=1 : len2
    video_path = file_List2{i};
    [pathstr, name, ext] = fileparts(video_path);
    file_name{i+len1, 1} =name;
end
file_name = sortrows(file_name, 1);
len = length(file_name(:, 1));
count = 0;
for i=1 : len-1
    if isequal(file_name(i, 1), file_name(i+1, 1))
        name = file_name{i, 1};
        fprintf(fid, '%s\r\n', name);
        count = count + 1;
    end
    
end

if isequal(file_name(len-1), file_name(len))
    name = file_name{len, 1};
    fprintf(fid, '%s\r\n', name);
     count = count + 1;
end

 count = count + 1;
 
 
 