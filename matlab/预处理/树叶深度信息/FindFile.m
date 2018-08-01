%% 
type = 0;
if type == 1
    %% 找出不同文件夹中的相同文件
    %从目标文件夹中找出与原始文件相同的文件，然后保存到其他文件夹
    source_path = 'D:\ELF-ramework\ELF-ramework\_expData\20161107T222805_抽样检测\leaf\';
    target_path = 'D:\ELF-ramework\ELF-ramework\_expData\20161107T222805_192x240\20161109T215504\leaf\';
    save_path = 'C:\Users\LiTao\Desktop\leaf\';
    img_path_list = dir([source_path,'*.jpg']);
    if isempty(img_path_list);
        error('设定的文件夹内没有任何视频，请重新检查...')
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
    %% 找出图片元素尺寸
    %从目标文件夹中找出与原始文件相同的文件，然后保存其图像大小
    source_path = 'D:\新建文件夹\';%%ps文件
    target_path = 'D:\ELF-ramework\测试数据\leaf\';
    img_path_list = dir([source_path,'*.jpg']);
    if isempty(img_path_list);
        error('设定的文件夹内没有任何视频，请重新检查...')
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