clear cll;
clc;
%% 对图片进行分块
saveDir1 = 'E:\caffe-windows-master\data&models\FCN-Leaf\SegmentationImage\';%原始图保存目录
saveDir2 = 'E:\caffe-windows-master\data&models\FCN-Leaf\SegmentationClass\';%原始标签图保存目录
dir_name1 = 'E:\caffe-windows-master\data&models\FCN-Leaf\基本数据\trainImage\';%原始图
dir_name2 = 'E:\caffe-windows-master\data&models\FCN-Leaf\基本数据\trainImageLabel\';%原始标签图
file_name = dir([dir_name1, '*.jpg']);
blockSize = 224;
for i = 1 : length(file_name)
    %%读取图片
    file = strcat(dir_name1, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    image = imread(file);
    [m, n, d] = size(image);
    image = imresize(image, [m*0.5, n*0.5]);
    [M, N, D] = size(image);
    
    %label image
    labelImage = imread(strcat(dir_name2, image_name, '.png'));
    labelImage = imresize(labelImage, [m*0.5, n*0.5]);
    
    %block
    rowNum = round(M/blockSize);
    colNum = round(N/blockSize);
    for row = 1 : 2 : 2*rowNum
        for col = 1 :2 : 2*colNum
            startRow = floor(M*row/(2*rowNum) - blockSize/2);
            startCol = floor(N*col/(2*colNum) - blockSize/2);
            if startRow < 1
                startRow = 1;
            end
            if ceil(startRow + blockSize) > M
                startRow = M - blockSize;
            end
            if startCol < 1
                startCol = 1;
            end
            if ceil(startCol + blockSize) > N
                startCol = N - blockSize;
            end
            name = strcat(image_name, '_', num2str(startRow), '_', num2str(startCol));
            
            imgPart = image(startRow:startRow+blockSize-1, startCol:startCol+blockSize-1, :);
            imwrite(imgPart, strcat(saveDir1, name, '.jpg'));
            
            labelImagePart = labelImage(startRow:startRow+blockSize-1, startCol:startCol+blockSize-1, :);
            labelImagePart((labelImagePart(:, :, 1) < 240)) = 0;
            labelImagePart(:, :, 2) = 0;
            labelImagePart(:, :, 3) = 0;
            labelImagePart((labelImagePart(:, :, 1) > 240)) = 128;
            [X, map] = rgb2ind(labelImagePart, 256);
            imwrite(X, map, strcat(saveDir2, name, '.png'));
            
%             grayImage = labelImage(startRow:startRow+blockSize-1, startCol:startCol+blockSize-1, 1);
%             grayImage((grayImage(:, :) < 240)) = 0;
%             grayImage((grayImage(:, :) > 240)) = 255;            
%             imwrite(grayImage, strcat(saveDir2, name, '.bmp'));
        end
    end
end