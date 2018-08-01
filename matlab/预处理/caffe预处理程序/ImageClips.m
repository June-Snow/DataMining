
%% 读取文件路径
saveDir = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\neg\';
dir_name = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\crop\有缺陷\';
SELECT = 1;%1：读取图片， 2：读取视频
if SELECT == 2
    file_List = getAllFiles(dir_name);
    str = [];
    if isempty(file_List);
        error('设定的文件夹内没有任何视频，请重新检查...')
    end
    for i = 1 : length(file_List)
        %读取视频
        video_path = file_List{i};
        [~, image_name, ext] = fileparts(video_path);       
        if strcmp(ext, '.avi') ~= 1
            continue;
        end
        video = VideoReader(video_path);

        image = read(video, 1);       %读取第一帧  
        batCrop(image, image_name, '.jpg', saveDir)
    end
else
    file_name = dir([dir_name, '*.jpg']);
    for i = 1 : length(file_name)
        %%读取图片
        file = strcat(dir_name, file_name(i).name);
        [~, image_name, ext] = fileparts(file);
        image = imread(file);
%         [M, N, ~] = size(image);
%         imwrite(image(1:ceil(M/2), :, :), strcat(saveDir, image_name, '_0', ext));
%         imwrite(image(ceil(M/2):end, :, :), strcat(saveDir, image_name, '_1', ext));
        batCrop(image, image_name, ext, saveDir);
    end
end




