
%% ��ȡ�ļ�·��
saveDir = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\neg\';
dir_name = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\crop\��ȱ��\';
SELECT = 1;%1����ȡͼƬ�� 2����ȡ��Ƶ
if SELECT == 2
    file_List = getAllFiles(dir_name);
    str = [];
    if isempty(file_List);
        error('�趨���ļ�����û���κ���Ƶ�������¼��...')
    end
    for i = 1 : length(file_List)
        %��ȡ��Ƶ
        video_path = file_List{i};
        [~, image_name, ext] = fileparts(video_path);       
        if strcmp(ext, '.avi') ~= 1
            continue;
        end
        video = VideoReader(video_path);

        image = read(video, 1);       %��ȡ��һ֡  
        batCrop(image, image_name, '.jpg', saveDir)
    end
else
    file_name = dir([dir_name, '*.jpg']);
    for i = 1 : length(file_name)
        %%��ȡͼƬ
        file = strcat(dir_name, file_name(i).name);
        [~, image_name, ext] = fileparts(file);
        image = imread(file);
%         [M, N, ~] = size(image);
%         imwrite(image(1:ceil(M/2), :, :), strcat(saveDir, image_name, '_0', ext));
%         imwrite(image(ceil(M/2):end, :, :), strcat(saveDir, image_name, '_1', ext));
        batCrop(image, image_name, ext, saveDir);
    end
end




