%% 深度图片扩充
% path = 'E:\leafOcclusion\备份文件\遮挡排序打分\';
% path1 = 'C:\Users\LiTao\Desktop\新建文件夹 (3)\深度图片\赋值图\';
% img_path1 = dir([path1,'*.jpg']);
% if isempty(img_path1);
%     error('设定的文件夹内没有任何视频，请重新检查...')
% end
% len1 = length(img_path1);
% 
% savePath = 'C:\Users\LiTao\Desktop\新建文件夹 (3)\深度图片\训练图\';
% 
% for i=1 : len1
%     file_path1 = strcat(path1, img_path1(i).name);
%     [~, name1, ext] = fileparts(file_path1);
%     imageGray = imread(file_path1);
%     
%     imageRGB = imread(strcat(path, name1,ext));
%     [m, n, ~] = size(imageRGB);
%     imageGray = imageGray(1:m, 1:n);
%     imageRGB(:, :, 1) = imageGray;
%     imageRGB(:, :, 2) = imageGray;
%     imageRGB(:, :, 3) = imageGray;
%     
%     imwrite(imageRGB, [savePath, name1, ext]);
%     imageRGB = imageRGB(:, end:-1:1, :);
%     imwrite(imageRGB, [savePath, name1, '_0', ext]);
% end

%% 图片扩充
% path1 = 'E:\leafOcclusion\备份文件\深度训练文件\240x426\';
% img_path1 = dir([path1,'*.jpg']);
% if isempty(img_path1);
%     error('设定的文件夹内没有任何视频，请重新检查...')
% end
% len = length(img_path1);
% 
% savePath = 'E:\leafOcclusion\备份文件\深度训练文件\240x426\';
% 
% for i=1 : len
%     file_path1 = strcat(path1, img_path1(i).name);
%     [~, name, ext] = fileparts(file_path1);
%     image = imread(file_path1);    
%     image = image(:, end:-1:1, :);
%     imwrite(image, [savePath, name, '_0', ext]);
%     
% end