%% 
type = 0;
if type == 1
    %% �ҳ���ͬ�ļ����е���ͬ�ļ�
    %��Ŀ���ļ������ҳ���ԭʼ�ļ���ͬ���ļ���Ȼ�󱣴浽�����ļ���
    source_path = 'D:\ELF-ramework\ELF-ramework\_expData\20161107T222805_�������\leaf\';
    target_path = 'D:\ELF-ramework\ELF-ramework\_expData\20161107T222805_192x240\20161109T215504\leaf\';
    save_path = 'C:\Users\LiTao\Desktop\leaf\';
    img_path_list = dir([source_path,'*.jpg']);
    if isempty(img_path_list);
        error('�趨���ļ�����û���κ���Ƶ�������¼��...')
    end
    len = length(img_path_list);
    i = 1;
    while i <= len
        file_path1 = strcat(source_path, img_path_list(i).name);
        [~, name, ext] = fileparts(file_path1);
        spath = strcat(target_path, name, ext);
        movepath = strcat(save_path, name, ext);
        copyfile(spath, movepath);
        i = i + 1;

    end
else
    %% �ҳ�ͼƬԪ�سߴ�
    %��Ŀ���ļ������ҳ���ԭʼ�ļ���ͬ���ļ���Ȼ�󱣴���ͼ���С
    source_path = 'D:\�½��ļ���\';%%ps�ļ�
    target_path = 'D:\ELF-ramework\��������\leaf\';
    img_path_list = dir([source_path,'*.jpg']);
    if isempty(img_path_list);
        error('�趨���ļ�����û���κ���Ƶ�������¼��...')
    end
    len = length(img_path_list);
    strSize = cell(len, 1);
    i = 1;
    while i <= len
        file_path1 = strcat(source_path, img_path_list(i).name);
        [~, name, ext] = fileparts(file_path1);
        spath = strcat(target_path, name, ext);
        img = imread(spath);
        [M, N, ~] = size(img);
        strSize{i, 1} = strcat(num2str(M),'*', num2str(N));
        i = i + 1;
    end
end