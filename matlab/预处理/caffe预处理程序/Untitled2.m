%% 样本扩充
saveDir = 'C:\Users\Litao\Desktop\aeroplane\label\';
dir_name = 'C:\Users\Litao\Desktop\aeroplane\label\';
file_name = dir([dir_name, '*.png']);
for i = 1 : length(file_name)
    %%读取图片
    file = strcat(dir_name, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    image = imread(file);
    [M, N, ~] = size(image);
    %上下对调
    img = image(end:-1:1, :, :);
    saveImg = strcat(saveDir, image_name, '_updown', ext);
    imwrite(img, saveImg);
    %左右对调
    img = image(:, end:-1:1, :);
    saveImg = strcat(saveDir, image_name, '_rightleft', ext);
    imwrite(img, saveImg);
    %旋转90
    imgRotate = imrotate(image,90);
    saveImg = strcat(saveDir, image_name, '_rotate90', ext);
    imwrite(imgRotate, saveImg);
    %旋转180
    imgRotate = imrotate(image,180);
    saveImg = strcat(saveDir, image_name, '_rotate180', ext);
    imwrite(imgRotate, saveImg);
    %旋转270
    imgRotate = imrotate(image,270);
    saveImg = strcat(saveDir, image_name, '_rotate270', ext);
    imwrite(imgRotate, saveImg);
    
    
end