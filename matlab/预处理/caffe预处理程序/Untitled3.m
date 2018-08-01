
%% �ѷֿ�ͼ��ϳ�����ͼ��
% clear all;
% close all;
% 
% saveDir = 'C:\Users\Litao\Desktop\test\Ч��ͼ\';%����Ŀ¼
% dir_name = 'C:\Users\Litao\Desktop\test\result\Pic_37540\';%Ŀ���ļ�
% file_name = dir([dir_name, '*.jpg']);
% effectPicture = zeros(1024, 1280);
% for i = 1 : length(file_name)
%     %%��ȡͼƬ
%     file = strcat(dir_name, file_name(i).name);
%     [~, image_name, ext] = fileparts(file);
%     nameSplit = regexp(image_name, '_', 'split');
%     row = str2num(nameSplit{3});
%     col = str2num(nameSplit{4});
%     image = imread(file);
%     img = image(:, :, 1);
%     img1 = img(59:427, 144:513);
%     img2 = imresize(img1, [224, 224]);
%     for k = 1 : 224
%         for m = 1 : 224
%             val = img2(k, m);
%             if val > 20                
%                 effectPicture(k+row-1, m+col-1) = 255;
%             end
%         end
%     end
% end
% %figure;imshow(effectPicture);
% imwrite(effectPicture, strcat(saveDir, nameSplit{1}, '_', nameSplit{2}, '.png'));

%% ���ݺϳ�����ͼ�񣬻�ԭ���Ч��ͼ
clear all;
close all;
saveDir = 'C:\Users\Litao\Desktop\test\';%����Ŀ¼
dir_name = 'C:\Users\Litao\Desktop\test\Ч��ͼ\';%Ŀ���ļ�
file_name = dir([dir_name, '*.png']);
for i = 1 : length(file_name)
    %%��ȡͼƬ
    file = strcat(dir_name, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    img1 = imread(file);
    %figure;imshow(img2);
    B=[0 0 1 0 0
        0 1 1 1 0
        1 1 1 1 1
        0 1 1 1 0
        0 0 1 0 0];
    img2=imdilate(img1,B);%ͼ��A1���ṹԪ��B����
    %figure;imshow(A2);
    img3 = img2 - img1;
    figure;imshow(img3);
    origionImg = imread(strcat('C:\Users\Litao\Desktop\test\', image_name, '.bmp'));
    effectPicture(:, :, 1) = origionImg;
    effectPicture(:, :, 2) = origionImg;
    effectPicture(:, :, 3) = origionImg;
    for row = 1 : 1024
        for col = 1 : 1280
            val = img3(row, col);
            if val > 100
                effectPicture(row, col, 1) = 250;
                effectPicture(row, col, 2:3) = 0;
            end
        end
    end
    figure;imshow(effectPicture);
    imwrite(effectPicture, strcat(saveDir, image_name,'_effectPicture', '.png'));
end




