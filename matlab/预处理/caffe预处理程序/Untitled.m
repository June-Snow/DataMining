
close all
% img = imread('C:\Users\Litao\Desktop\20170809152414712_1.11_22163417.jpg');
% figure;imshow(img);
% img(342:382, 1154:end, :) = img(342:-1:302, 1154:end, :);
% figure;imshow(img);
% 
% img(424:464, 1154:end, :) = img(464:464+40, 1154:end, :);
% figure;imshow(img);
% 
% img(342:464, 1154:1173, :) = img(342:464, 1154:-1:1154-19, :);
% figure;imshow(img);
% 
% img(342:464, 1252:end, :) = img(342:464, 1100:1100+end-1252, :);
% figure;imshow(img);
% imwrite(img, 'C:\Users\Litao\Desktop\20170809152414712_22163417.jpg')



% dir_name = 'C:\Users\Litao\Desktop\0909布\cnn\train\大图\';
% save_path = 'C:\Users\Litao\Desktop\0909布\cnn\train\crop\';
% file_name = dir([dir_name, '*.jpg']);
% for i = 1 : length(file_name)
%     %%读取图片
%     file = strcat(dir_name, file_name(i).name);
%     [~, image_name, ext] = fileparts(file);
%     image = imread(file);
%     [M, N, ~] = size(image);
%     
%     imwrite(image(1:ceil(M/3)+30, 1:ceil(N/3)+30, :), strcat(save_path, image_name, '_1.jpg'));
%     imwrite(image(1:ceil(M/3)+30, ceil(N/3)-30:ceil(2*N/3), :), strcat(save_path, image_name, '_2.jpg'));
%     imwrite(image(1:ceil(M/3)+30, ceil(2*N/3)-30:N, :), strcat(save_path, image_name, '_3.jpg'));
%     
%     imwrite(image(ceil(M/3)-30:ceil(2*M/3), 1:ceil(N/3)+30, :), strcat(save_path, image_name, '_4.jpg'));
%     imwrite(image(ceil(M/3)-30:ceil(2*M/3), ceil(N/3)-30:ceil(2*N/3), :), strcat(save_path, image_name, '_5.jpg'));
%     imwrite(image(ceil(M/3)-30:ceil(2*M/3), ceil(2*N/3)-30:N, :), strcat(save_path, image_name, '_6.jpg'));
%     
%     imwrite(image(ceil(2*M/3)-30:M, 1:ceil(N/3)+30, :), strcat(save_path, image_name, '_7.jpg'));
%     imwrite(image(ceil(2*M/3)-30:M, ceil(N/3)-30:ceil(2*N/3), :), strcat(save_path, image_name, '_8.jpg'));
%     imwrite(image(ceil(2*M/3)-30:M, ceil(2*N/3)-30:N, :), strcat(save_path, image_name, '_9.jpg'));
%     
% end


% dir_name = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\pos\origin\';
% save_path = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\pos\';
% file_name = dir([dir_name, '*.jpg']);
% for i = 1 : length(file_name)
%     %%读取图片
%     file = strcat(dir_name, file_name(i).name);
%     [~, image_name, ext] = fileparts(file);
%     image = imread(file);
% %     image = rgb2gray(image);
% %     %figure;imshow(image);
% %     [M, N, ~] = size(image);
% %     img = uint8(zeros(93, 93));
% %     img(6:89, 6:89) = image;
% %     img(1:5, :) = img(6:10, :);
% %     img(90:93, :) = img(86:89, :);
% %     img(:, 1:5) = img(:, 6:10);
% %     img(:, 90:93) = img(:, 86:89);
%     %figure;imshow(img);
%     name = strcat('1', image_name(3:end));
%     imwrite(image, strcat(save_path, name, '.jpg'));
% end

img = imread('C:\Users\Serissa\Desktop\origin\9号栏位体重分布曲线.png');
img1 = img(297:387, 115:149, :);
figure;imshow(img1);
img2 = img(630:665, 600:810, :);
figure;imshow(img2);

path = 'C:\Users\Serissa\Desktop\origin\\';
img_path_list1 = dir([path,'*.png']);
len1 = length(img_path_list1);
for i = 2 : len1
    file_path1 = strcat(path, img_path_list1(i).name);
    [~, name, ext] = fileparts(file_path1);    
    image = imread(file_path1);
    image(297:387, 115:149, :) = img1;
    image(630:665, 600:810, :) = img2;
    figure;imshow(image);
    imwrite(image, strcat(path, name, '.png'));
    
end


% savePath = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\test\';
% saveTextPath = strcat(savePath, 'test.txt');
% test = fopen(saveTextPath,'wt');
% for i =1 : len1
%         str = strcat('test/', imgName1{i, 1}, '\t', num2str('1'), '\r\n');%
%         fprintf(test, str);
% end
% fclose(test);
