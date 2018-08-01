    
path = 'C:\Users\LiTao\Desktop\对比\20161107T222805_192x240\leaf\';
img_path_list1 = dir([path,'*.jpg']);
len1 = length(img_path_list1);

path = 'C:\Users\LiTao\Desktop\对比\20161112T092322sift192x240\leaf\';
img_path_list2 = dir([path,'*.jpg']);
len2 = length(img_path_list2);

path = 'C:\Users\LiTao\Desktop\对比\20161112T211648addColor192x240\leaf\';
img_path_list3 = dir([path,'*.jpg']);
len3 = length(img_path_list3);

strName = cell(len1+len2+len3, 1);
k = 1;
i = 1;
while i <= len1
    file_path1 = strcat(path, img_path_list1(i).name);
    [~, name, ext] = fileparts(file_path1);
    strName{k, 1} = name;
    k = k + 1;
    i = i + 1;
end

i = 1;
while i <= len2
    file_path1 = strcat(path, img_path_list2(i).name);
    [~, name, ext] = fileparts(file_path1);
    strName{k, 1} = name;
    k = k + 1;
    i = i + 1;
end

i = 1;
while i <= len3
    file_path1 = strcat(path, img_path_list3(i).name);
    [~, name, ext] = fileparts(file_path1);
    strName{k, 1} = name;
    k = k + 1;
    i = i + 1;
end

strName = sortrows(strName);
strName = unique(strName);
len = length(strName);

% path1 = 'D:\ELF-ramework\ELF-ramework\_expData\20161107T222805_192x240\20161109T215504\leaf\';
% path2 = 'D:\ELF-ramework\ELF-ramework\_expData\20161112T092322sift192x240\20161112T092322\leaf\';
path3 = 'D:\ELF-ramework\ELF-ramework\_expData\20161112T211648addColor192x240\20161112T211648\leaf\';
% spath1 = 'C:\Users\LiTao\Desktop\新建文件夹\20161107T222805_192x240\';
% spath2 = 'C:\Users\LiTao\Desktop\新建文件夹\20161112T092322sift192x240\';
spath3 = 'C:\Users\LiTao\Desktop\对比\同等对比\20161113T103045siftaddnoleaf192x240\';

for i = 1 : len
%     path = strcat(path1, strName{i}, '.jpg');
%     savePath = strcat(spath1, strName{i}, '.jpg');
%     copyfile(path, savePath);
%     
%     path = strcat(path2, strName{i}, '.jpg');
%     savePath = strcat(spath2, strName{i}, '.jpg');
%     copyfile(path, savePath);
    
    path = strcat(path3, strName{i}, '.jpg');
    savePath = strcat(spath3, strName{i}, '.jpg');
    copyfile(path, savePath);
end











    