%% 根据抠图生成label图像
% 类别名称 R G B 
% background 0 0 0 背景 
% aeroplane 128 0 0 飞机 
% bicycle 0 128 0 
% bird 128 128 0 
% boat 0 0 128 
saveDir = 'G:\vegetable\FCN-2-Vegetable\SegmentationClass\';%保存目录
dir_name = 'G:\vegetable\FCN-2-Vegetable\label\';%目标文件
file_name = dir([dir_name, '*.bmp']);
for i = 1 : length(file_name)
    %%读取图片
    file = strcat(dir_name, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    image = imread(file);
    img = uint8(zeros(224, 224, 3));
    img1 = uint8(zeros(224, 224));
    img1((image(:, :) > 0)) = 128;
    img(:, :, 1) = img1;
    [X, map] = rgb2ind(img, 256);
    imwrite(X, map, strcat(saveDir, image_name, '.png'));
end