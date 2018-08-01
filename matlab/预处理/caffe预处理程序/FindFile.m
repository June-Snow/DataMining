%% 根据现有图像从原始图像中找出对应的图像
% saveDir = 'J:\树叶\原始图片标签\';%保存目录
% dir_name1 = 'J:\树叶\原始图片标签\';%目标文件
% dir_name2 = 'J:\树叶\train\';%原始目标文件
% file_name = dir([dir_name1, '*.jpg']);
% for i = 1 : length(file_name)
%     %%读取图片
%     file = strcat(dir_name1, file_name(i).name);
%     [~, image_name, ext] = fileparts(file);
%     img = imread(file);
%     imwrite(img, strcat(saveDir, image_name, '.png'));
% %     
% %     if(exist(strcat(dir_name2, image_name, '.jpg'),'file'))
% %         copyfile(strcat(dir_name2, image_name, '.jpg'), strcat(saveDir, image_name, '.jpg'));
% %     end
% end


%% 根据现有图像从原始图像中找出对应的图像
saveDir = 'G:\caffe-windows-master\python\lsingModelData\samples - 1\';%保存目录
dir_name = 'G:\caffe-windows-master\python\lsingModelData\samples\';%原始目标文件
file_name = dir([dir_name, '*.jpg']);
for i = 1 : length(file_name)
    %%读取图片
    file = strcat(dir_name, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    img = imread(file);
    img = imresize(img, [227, 227]);
    imwrite(img, strcat(saveDir, image_name, '.jpg'));
%     
%     if(exist(strcat(dir_name2, image_name, '.jpg'),'file'))
%         copyfile(strcat(dir_name2, image_name, '.jpg'), strcat(saveDir, image_name, '.jpg'));
%     end
end