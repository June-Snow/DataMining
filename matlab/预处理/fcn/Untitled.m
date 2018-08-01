%% 
saveDir = 'E:\caffe-windows-master\data&models\FCN-Leaf\LeafOcclusion\onlyLeafImage\onlyLeafImage\';%����Ŀ¼
originImage = 'E:\caffe-windows-master\data&models\FCN-Leaf\��������\trainImage\';%Ŀ���ļ�
labelImage = 'E:\caffe-windows-master\data&models\FCN-Leaf\��������\trainImageLabel\';%Ŀ���ļ�
file_name = dir([originImage, '*.jpg']);
for i = 1 : length(file_name)
    %%��ȡͼƬ
    file = strcat(originImage, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    origin = imread(file);
    label = imread(strcat(labelImage, image_name, '.png'));
    
    origin((label(:, :, :) < 230)) = 255;    
    imwrite(origin, strcat(saveDir, image_name, '.bmp'));
end


%% ͼƬ��ȡ
% saveDir = 'F:\PopCanDetection\fcn-image\label\';%����Ŀ¼
% dir_name = 'F:\PopCanDetection\fcn-image\origin\';%Ŀ���ļ�
% file_name = dir([dir_name, '*.jpg']);
% for i = 1 : length(file_name)
%     %%��ȡͼƬ
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

% %% ͼƬ��С
% saveDir = 'H:\��Ҷ\resize\trainLabel\';%����Ŀ¼
% dir_name = 'H:\��Ҷ\trainLabel\';%Ŀ���ļ�
% file_name = dir([dir_name, '*.png']);
% for i = 1 : length(file_name)
%     %%��ȡͼƬ
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

%% ɾ���ļ�
% saveDir = 'C:\Users\Serissa\Desktop\�½��ļ���\';%����Ŀ¼
% dir_name = 'E:\caffe-windows-master\data&models\FCN-Leaf\��������\train\';%Ŀ���ļ�
% dir_path = 'E:\caffe-windows-master\data&models\FCN-Leaf\image\';
% file_name = dir([dir_name, '*.jpg']);
% for i = 1 : length(file_name)
%     %%��ȡͼƬ
%     file = strcat(dir_name, file_name(i).name);
%     [~, image_name, ext] = fileparts(file);
%     movefile(strcat(dir_path, image_name, ext), strcat(saveDir, image_name, ext));  
% end