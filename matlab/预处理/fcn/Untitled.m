%% 
saveDir = 'E:\caffe-windows-master\data&models\FCN-Leaf\LeafOcclusion\onlyLeafImage\onlyLeafImage\';%保存目录
originImage = 'E:\caffe-windows-master\data&models\FCN-Leaf\基本数据\trainImage\';%目标文件
labelImage = 'E:\caffe-windows-master\data&models\FCN-Leaf\基本数据\trainImageLabel\';%目标文件
file_name = dir([originImage, '*.jpg']);
for i = 1 : length(file_name)
    %%读取图片
    file = strcat(originImage, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    origin = imread(file);
    label = imread(strcat(labelImage, image_name, '.png'));
    
    origin((label(:, :, :) < 230)) = 255;    
    imwrite(origin, strcat(saveDir, image_name, '.bmp'));
end


%% 图片截取
% saveDir = 'F:\PopCanDetection\fcn-image\label\';%保存目录
% dir_name = 'F:\PopCanDetection\fcn-image\origin\';%目标文件
% file_name = dir([dir_name, '*.jpg']);
% for i = 1 : length(file_name)
%     %%读取图片
%     file = strcat(dir_name, file_name(i).name);
%     [~, image_name, ext] = fileparts(file);
%     image = imread(file);
%     startRow = 1;
%     startCol = 360;
%     endRow = 1024;
%     endCol = 840;
%     %imagePart = image(startRow: endRow, startCol:endCol, :);
% 
%     imwrite(image, strcat(saveDir, image_name, '.png'));
% end

% %% 图片缩小
% saveDir = 'H:\树叶\resize\trainLabel\';%保存目录
% dir_name = 'H:\树叶\trainLabel\';%目标文件
% file_name = dir([dir_name, '*.png']);
% for i = 1 : length(file_name)
%     %%读取图片
%     file = strcat(dir_name, file_name(i).name);
%     [~, image_name, ext] = fileparts(file);
%     image = imread(file);
%     [M, N, D] = size(image);
%     resizeImage = imresize(image, [M*0.5, N*0.5]);
% % 
% %     img = uint8(zeros(112, 112, 3));
% %     img1 = uint8(zeros(112, 112));
% %     img1((resizeImage(:, :) > 0)) = 128;
% %     img(:, :, 1) = img1;
% %     [X, map] = rgb2ind(img, 256);
% %     imwrite(X, map, strcat(saveDir, image_name, '.png'));
%     
%     imwrite(resizeImage, strcat(saveDir, image_name, '.png'));
% end

%% 删除文件
% saveDir = 'C:\Users\Serissa\Desktop\新建文件夹\';%保存目录
% dir_name = 'E:\caffe-windows-master\data&models\FCN-Leaf\基本数据\train\';%目标文件
% dir_path = 'E:\caffe-windows-master\data&models\FCN-Leaf\image\';
% file_name = dir([dir_name, '*.jpg']);
% for i = 1 : length(file_name)
%     %%读取图片
%     file = strcat(dir_name, file_name(i).name);
%     [~, image_name, ext] = fileparts(file);
%     movefile(strcat(dir_path, image_name, ext), strcat(saveDir, image_name, ext));  
% end