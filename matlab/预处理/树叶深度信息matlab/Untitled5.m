%%
type = 0;
if type == 1
    %% �ҳ���ͬ�ļ����е���ͬ�ļ�
    path = 'D:\ELF-ramework\ELF-ramework\_expData\20161107T222805_�������\leaf\';%%ps�ļ�
    path1 = 'D:\ELF-ramework\ELF-ramework\_expData\20161107T222805_192x240\20161109T215504\leaf\';
    path2 = 'C:\Users\LiTao\Desktop\leaf\';
    img_path_list = dir([path,'*.jpg']);
    if isempty(img_path_list);
        error('�趨���ļ�����û���κ���Ƶ�������¼��...')
    end
    len = length(img_path_list);
    i = 1;
    while i <= len
        file_path1 = strcat(path, img_path_list(i).name);
        [~, name, ext] = fileparts(file_path1);
        spath = strcat(path1, name, ext);
        movepath = strcat(path2, name, ext);
        copyfile(spath, movepath);
        i = i + 1;

    end
else
    %% �ҳ�ͼƬԪ�سߴ�
    path = 'D:\�½��ļ���\';%%ps�ļ�
    path1 = 'D:\ELF-ramework\��������\leaf\';
    img_path_list = dir([path,'*.jpg']);
    if isempty(img_path_list);
        error('�趨���ļ�����û���κ���Ƶ�������¼��...')
    end
    len = length(img_path_list);
    strSize = cell(len, 1);
    i = 1;
    while i <= len
        file_path1 = strcat(path, img_path_list(i).name);
        [~, name, ext] = fileparts(file_path1);
        spath = strcat(path1, name, ext);
        img = imread(spath);
        [M, N, ~] = size(img);
        strSize{i, 1} = strcat(num2str(M),'*', num2str(N));
        i = i + 1;
    end
end