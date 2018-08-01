% image1 = imread('C:\Users\Serissa\Desktop\vegetable\ԭͼ\20170814134856_0.jpg');
% image2 = imread('C:\Users\Serissa\Desktop\vegetable\ԭͼ\20170814134856_1.jpg');
% img = [image1;image2];
% imwrite(img, 'C:\Users\Serissa\Desktop\vegetable\ԭͼ\20170814134856.jpg');
clear all
clc
image = imread('I:\caffeMode\83X83\test\20170818155207.jpg');
path = 'I:\caffeMode\83X83\retina_train\retina_201708221328_83_83_iter_90000predict_result.xls';
[data, imageName] = xlsread(path);
course = data(:, 3);
for i=1 : length(imageName)
    if course(i) < 0.6
        name = imageName{i};
        name = name(1:end-4);
        name = regexp(name, '_', 'split');
        row = str2num(name{2});
        col = str2num(name{3});
        image(row:row+2, col:col+99, :) = 0;
        image(row:row+2, col:col+99, 1) = 255;
        image(row+99:row+101, col:col+99, :) = 0;
        image(row+99:row+101, col:col+99, 1) = 255;
        image(row:row+99, col:col+2, :) = 0;
        image(row:row+99, col:col+2, 1) = 255;
        image(row:row+99, col+99:col+101, :) = 0;
        image(row:row+99, col+99:col+101, 1) = 255;
    end
    
end
figure;imshow(image);
