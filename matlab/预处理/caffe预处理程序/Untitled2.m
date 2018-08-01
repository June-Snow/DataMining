%% ��������
saveDir = 'C:\Users\Litao\Desktop\aeroplane\label\';
dir_name = 'C:\Users\Litao\Desktop\aeroplane\label\';
file_name = dir([dir_name, '*.png']);
for i = 1 : length(file_name)
    %%��ȡͼƬ
    file = strcat(dir_name, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    image = imread(file);
    [M, N, ~] = size(image);
    %���¶Ե�
    img = image(end:-1:1, :, :);
    saveImg = strcat(saveDir, image_name, '_updown', ext);
    imwrite(img, saveImg);
    %���ҶԵ�
    img = image(:, end:-1:1, :);
    saveImg = strcat(saveDir, image_name, '_rightleft', ext);
    imwrite(img, saveImg);
    %��ת90
    imgRotate = imrotate(image,90);
    saveImg = strcat(saveDir, image_name, '_rotate90', ext);
    imwrite(imgRotate, saveImg);
    %��ת180
    imgRotate = imrotate(image,180);
    saveImg = strcat(saveDir, image_name, '_rotate180', ext);
    imwrite(imgRotate, saveImg);
    %��ת270
    imgRotate = imrotate(image,270);
    saveImg = strcat(saveDir, image_name, '_rotate270', ext);
    imwrite(imgRotate, saveImg);
    
    
end