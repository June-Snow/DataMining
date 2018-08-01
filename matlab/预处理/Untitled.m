% img = imread('C:\Users\Serissa\Desktop\5815821_1393728267543.jpg');
% [m, n, ~] = size(img);
% figure;imshow(img);
% for i = 1 : m-20
%     for j = 1 : n
%         r = img(i, j, 1);
%         g = img(i, j, 2);
%         b = img(i, j, 3);
%         if r > 220 && g >220 && b >220
%             img(i, j, 1) = 67;
%             img(i, j, 2) = 142;
%             img(i, j, 3) = 219;
%         end
%     end
% end
% figure;imshow(img);
% imwrite(img, 'C:\Users\Serissa\Desktop\1393728267543.jpg');
close all;
img = imread('C:\Users\Serissa\Desktop\1202\Pic_2017_12_02_095657_0.bmp');
figure;imshow(img);
img1 = 255-img;
figure;imshow(img1);
%
blockWidth  = 40;
blockHeight = 5;
%第一排
index = [58, 160, 262, 364, 465, 568, 670, 776, 874, 977, 1072, 1174];
startRow = 20;
for i = startRow : blockHeight : 267 - blockHeight
    indexMean0 = mean(mean(img1(i:i+blockHeight, index(1)-blockWidth/2:index(1)+blockWidth/2)));
    img1(i:i+blockHeight, 1:index(1)-blockWidth/2) = indexMean0;
    
    indexMean1 = mean(mean(img1(i:i+blockHeight, index(2)-blockWidth/2:index(2)+blockWidth/2)));
    img1(i:i+blockHeight, index(1)+blockWidth/2:index(2)-blockWidth/2) = (indexMean0 + indexMean1)/2;
    
    indexMean2 = mean(mean(img1(i:i+blockHeight, index(3)-blockWidth/2:index(3)+blockWidth/2)));
    img1(i:i+blockHeight, index(2)+blockWidth/2:index(3)-blockWidth/2) = (indexMean1 + indexMean2)/2;
    
    indexMean3 = mean(mean(img1(i:i+blockHeight, index(4)-blockWidth/2:index(4)+blockWidth/2)));
    img1(i:i+blockHeight, index(3)+blockWidth/2:index(4)-blockWidth/2) = (indexMean2 + indexMean3)/2;
    
    indexMean4 = mean(mean(img1(i:i+blockHeight, index(5)-blockWidth/2:index(5)+blockWidth/2)));
    img1(i:i+blockHeight, index(4)+blockWidth/2:index(5)-blockWidth/2) = (indexMean3 + indexMean4)/2;
    
    indexMean5 = mean(mean(img1(i:i+blockHeight, index(6)-blockWidth/2:index(6)+blockWidth/2)));
    img1(i:i+blockHeight, index(5)+blockWidth/2:index(6)-blockWidth/2) = (indexMean4 + indexMean5)/2;
    
    indexMean6 = mean(mean(img1(i:i+blockHeight, index(7)-blockWidth/2:index(7)+blockWidth/2)));
    img1(i:i+blockHeight, index(6)+blockWidth/2:index(7)-blockWidth/2) = (indexMean5 + indexMean6)/2;
    
    indexMean7 = mean(mean(img1(i:i+blockHeight, index(8)-blockWidth/2:index(8)+blockWidth/2)));
    img1(i:i+blockHeight, index(7)+blockWidth/2:index(8)-blockWidth/2) = (indexMean6 + indexMean7)/2;
    
    indexMean8 = mean(mean(img1(i:i+blockHeight, index(9)-blockWidth/2:index(9)+blockWidth/2)));
    img1(i:i+blockHeight, index(8)+blockWidth/2:index(9)-blockWidth/2) = (indexMean7 + indexMean8)/2;
    
    indexMean9 = mean(mean(img1(i:i+blockHeight, index(10)-blockWidth/2:index(10)+blockWidth/2)));
    img1(i:i+blockHeight, index(9)+blockWidth/2:index(10)-blockWidth/2) = (indexMean8 + indexMean9)/2;
    
    indexMean10 = mean(mean(img1(i:i+blockHeight, index(11)-blockWidth/2:index(11)+blockWidth/2)));
    img1(i:i+blockHeight, index(10)+blockWidth/2:index(11)-blockWidth/2) = (indexMean9 + indexMean10)/2;
    
    indexMean11 = mean(mean(img1(i:i+blockHeight, index(12)-blockWidth/2:index(12)+blockWidth/2)));
    img1(i:i+blockHeight, index(11)+blockWidth/2:index(12)-blockWidth/2) = (indexMean10 + indexMean11)/2;
    
    indexMean12 = mean(mean(img1(i:i+blockHeight, 1256:end)));
    img1(i:i+blockHeight, index(12)+blockWidth/2:1256) = (indexMean11 + indexMean12)/2;
    
end

%第二排
index = [24, 126, 229, 329, 431, 531, 632, 736, 835, 932, 1034, 1137, 1232];
startRow = 280;
for i = startRow : blockHeight : 523 - blockHeight
    indexMean0 = mean(mean(img1(i:i+blockHeight, index(1)-blockWidth/2:index(1)+blockWidth/2)));
    %img1(i:i+blockHeight, 1:index(1)-blockWidth/2) = indexMean0;
    
    indexMean1 = mean(mean(img1(i:i+blockHeight, index(2)-blockWidth/2:index(2)+blockWidth/2)));
    img1(i:i+blockHeight, index(1)+blockWidth/2:index(2)-blockWidth/2) = (indexMean0 + indexMean1)/2;
    
    indexMean2 = mean(mean(img1(i:i+blockHeight, index(3)-blockWidth/2:index(3)+blockWidth/2)));
    img1(i:i+blockHeight, index(2)+blockWidth/2:index(3)-blockWidth/2) = (indexMean1 + indexMean2)/2;
    
    indexMean3 = mean(mean(img1(i:i+blockHeight, index(4)-blockWidth/2:index(4)+blockWidth/2)));
    img1(i:i+blockHeight, index(3)+blockWidth/2:index(4)-blockWidth/2) = (indexMean2 + indexMean3)/2;
    
    indexMean4 = mean(mean(img1(i:i+blockHeight, index(5)-blockWidth/2:index(5)+blockWidth/2)));
    img1(i:i+blockHeight, index(4)+blockWidth/2:index(5)-blockWidth/2) = (indexMean3 + indexMean4)/2;
    
    indexMean5 = mean(mean(img1(i:i+blockHeight, index(6)-blockWidth/2:index(6)+blockWidth/2)));
    img1(i:i+blockHeight, index(5)+blockWidth/2:index(6)-blockWidth/2) = (indexMean4 + indexMean5)/2;
    
    indexMean6 = mean(mean(img1(i:i+blockHeight, index(7)-blockWidth/2:index(7)+blockWidth/2)));
    img1(i:i+blockHeight, index(6)+blockWidth/2:index(7)-blockWidth/2) = (indexMean5 + indexMean6)/2;
    
    indexMean7 = mean(mean(img1(i:i+blockHeight, index(8)-blockWidth/2:index(8)+blockWidth/2)));
    img1(i:i+blockHeight, index(7)+blockWidth/2:index(8)-blockWidth/2) = (indexMean6 + indexMean7)/2;
    
    indexMean8 = mean(mean(img1(i:i+blockHeight, index(9)-blockWidth/2:index(9)+blockWidth/2)));
    img1(i:i+blockHeight, index(8)+blockWidth/2:index(9)-blockWidth/2) = (indexMean7 + indexMean8)/2;
    
    indexMean9 = mean(mean(img1(i:i+blockHeight, index(10)-blockWidth/2:index(10)+blockWidth/2)));
    img1(i:i+blockHeight, index(9)+blockWidth/2:index(10)-blockWidth/2) = (indexMean8 + indexMean9)/2;
    
    indexMean10 = mean(mean(img1(i:i+blockHeight, index(11)-blockWidth/2:index(11)+blockWidth/2)));
    img1(i:i+blockHeight, index(10)+blockWidth/2:index(11)-blockWidth/2) = (indexMean9 + indexMean10)/2;
    
    indexMean11 = mean(mean(img1(i:i+blockHeight, index(12)-blockWidth/2:index(12)+blockWidth/2)));
    img1(i:i+blockHeight, index(11)+blockWidth/2:index(12)-blockWidth/2) = (indexMean10 + indexMean11)/2;
    
    indexMean12 = mean(mean(img1(i:i+blockHeight, index(13)-blockWidth/2:index(13)+blockWidth/2)));
    img1(i:i+blockHeight, index(12)+blockWidth/2:index(13)-blockWidth/2) = (indexMean11 + indexMean12)/2;
    
    img1(i:i+blockHeight, index(13)+blockWidth/2:end) = indexMean12;
end

%第三排
index = [21, 119, 223, 324, 425, 527, 631, 729, 836, 936, 1036, 1134, 1230];
startRow = 540;
for i = startRow : blockHeight : 786 - blockHeight
    indexMean0 = mean(mean(img1(i:i+blockHeight, index(1)-blockWidth/2:index(1)+blockWidth/2)));
    %img1(i:i+blockHeight, 1:index(1)-blockWidth/2) = indexMean0;
    
    indexMean1 = mean(mean(img1(i:i+blockHeight, index(2)-blockWidth/2:index(2)+blockWidth/2)));
    img1(i:i+blockHeight, index(1)+blockWidth/2:index(2)-blockWidth/2) = (indexMean0 + indexMean1)/2;
    
    indexMean2 = mean(mean(img1(i:i+blockHeight, index(3)-blockWidth/2:index(3)+blockWidth/2)));
    img1(i:i+blockHeight, index(2)+blockWidth/2:index(3)-blockWidth/2) = (indexMean1 + indexMean2)/2;
    
    indexMean3 = mean(mean(img1(i:i+blockHeight, index(4)-blockWidth/2:index(4)+blockWidth/2)));
    img1(i:i+blockHeight, index(3)+blockWidth/2:index(4)-blockWidth/2) = (indexMean2 + indexMean3)/2;
    
    indexMean4 = mean(mean(img1(i:i+blockHeight, index(5)-blockWidth/2:index(5)+blockWidth/2)));
    img1(i:i+blockHeight, index(4)+blockWidth/2:index(5)-blockWidth/2) = (indexMean3 + indexMean4)/2;
    
    indexMean5 = mean(mean(img1(i:i+blockHeight, index(6)-blockWidth/2:index(6)+blockWidth/2)));
    img1(i:i+blockHeight, index(5)+blockWidth/2:index(6)-blockWidth/2) = (indexMean4 + indexMean5)/2;
    
    indexMean6 = mean(mean(img1(i:i+blockHeight, index(7)-blockWidth/2:index(7)+blockWidth/2)));
    img1(i:i+blockHeight, index(6)+blockWidth/2:index(7)-blockWidth/2) = (indexMean5 + indexMean6)/2;
    
    indexMean7 = mean(mean(img1(i:i+blockHeight, index(8)-blockWidth/2:index(8)+blockWidth/2)));
    img1(i:i+blockHeight, index(7)+blockWidth/2:index(8)-blockWidth/2) = (indexMean6 + indexMean7)/2;
    
    indexMean8 = mean(mean(img1(i:i+blockHeight, index(9)-blockWidth/2:index(9)+blockWidth/2)));
    img1(i:i+blockHeight, index(8)+blockWidth/2:index(9)-blockWidth/2) = (indexMean7 + indexMean8)/2;
    
    indexMean9 = mean(mean(img1(i:i+blockHeight, index(10)-blockWidth/2:index(10)+blockWidth/2)));
    img1(i:i+blockHeight, index(9)+blockWidth/2:index(10)-blockWidth/2) = (indexMean8 + indexMean9)/2;
    
    indexMean10 = mean(mean(img1(i:i+blockHeight, index(11)-blockWidth/2:index(11)+blockWidth/2)));
    img1(i:i+blockHeight, index(10)+blockWidth/2:index(11)-blockWidth/2) = (indexMean9 + indexMean10)/2;
    
    indexMean11 = mean(mean(img1(i:i+blockHeight, index(12)-blockWidth/2:index(12)+blockWidth/2)));
    img1(i:i+blockHeight, index(11)+blockWidth/2:index(12)-blockWidth/2) = (indexMean10 + indexMean11)/2;
    
    indexMean12 = mean(mean(img1(i:i+blockHeight, index(13)-blockWidth/2:index(13)+blockWidth/2)));
    img1(i:i+blockHeight, index(12)+blockWidth/2:index(13)-blockWidth/2) = (indexMean11 + indexMean12)/2;
    
    img1(i:i+blockHeight, index(13)+blockWidth/2:end) = indexMean12;
end

%第四排
index = [24, 130, 232, 333, 437, 538, 642, 745, 847, 947, 1048, 1148, 1247];
startRow = 796;
for i = startRow : blockHeight : 1024 - blockHeight
    indexMean0 = mean(mean(img1(i:i+blockHeight, index(1)-blockWidth/2:index(1)+blockWidth/2)));
    %img1(i:i+blockHeight, 1:index(1)-blockWidth/2) = indexMean0;
    
    indexMean1 = mean(mean(img1(i:i+blockHeight, index(2)-blockWidth/2:index(2)+blockWidth/2)));
    img1(i:i+blockHeight, index(1)+blockWidth/2:index(2)-blockWidth/2) = (indexMean0 + indexMean1)/2;
    
    indexMean2 = mean(mean(img1(i:i+blockHeight, index(3)-blockWidth/2:index(3)+blockWidth/2)));
    img1(i:i+blockHeight, index(2)+blockWidth/2:index(3)-blockWidth/2) = (indexMean1 + indexMean2)/2;
    
    indexMean3 = mean(mean(img1(i:i+blockHeight, index(4)-blockWidth/2:index(4)+blockWidth/2)));
    img1(i:i+blockHeight, index(3)+blockWidth/2:index(4)-blockWidth/2) = (indexMean2 + indexMean3)/2;
    
    indexMean4 = mean(mean(img1(i:i+blockHeight, index(5)-blockWidth/2:index(5)+blockWidth/2)));
    img1(i:i+blockHeight, index(4)+blockWidth/2:index(5)-blockWidth/2) = (indexMean3 + indexMean4)/2;
    
    indexMean5 = mean(mean(img1(i:i+blockHeight, index(6)-blockWidth/2:index(6)+blockWidth/2)));
    img1(i:i+blockHeight, index(5)+blockWidth/2:index(6)-blockWidth/2) = (indexMean4 + indexMean5)/2;
    
    indexMean6 = mean(mean(img1(i:i+blockHeight, index(7)-blockWidth/2:index(7)+blockWidth/2)));
    img1(i:i+blockHeight, index(6)+blockWidth/2:index(7)-blockWidth/2) = (indexMean5 + indexMean6)/2;
    
    indexMean7 = mean(mean(img1(i:i+blockHeight, index(8)-blockWidth/2:index(8)+blockWidth/2)));
    img1(i:i+blockHeight, index(7)+blockWidth/2:index(8)-blockWidth/2) = (indexMean6 + indexMean7)/2;
    
    indexMean8 = mean(mean(img1(i:i+blockHeight, index(9)-blockWidth/2:index(9)+blockWidth/2)));
    img1(i:i+blockHeight, index(8)+blockWidth/2:index(9)-blockWidth/2) = (indexMean7 + indexMean8)/2;
    
    indexMean9 = mean(mean(img1(i:i+blockHeight, index(10)-blockWidth/2:index(10)+blockWidth/2)));
    img1(i:i+blockHeight, index(9)+blockWidth/2:index(10)-blockWidth/2) = (indexMean8 + indexMean9)/2;
    
    indexMean10 = mean(mean(img1(i:i+blockHeight, index(11)-blockWidth/2:index(11)+blockWidth/2)));
    img1(i:i+blockHeight, index(10)+blockWidth/2:index(11)-blockWidth/2) = (indexMean9 + indexMean10)/2;
    
    indexMean11 = mean(mean(img1(i:i+blockHeight, index(12)-blockWidth/2:index(12)+blockWidth/2)));
    img1(i:i+blockHeight, index(11)+blockWidth/2:index(12)-blockWidth/2) = (indexMean10 + indexMean11)/2;
    
    indexMean12 = mean(mean(img1(i:i+blockHeight, index(13)-blockWidth/2:index(13)+blockWidth/2)));
    img1(i:i+blockHeight, index(12)+blockWidth/2:index(13)-blockWidth/2) = (indexMean11 + indexMean12)/2;
    
    img1(i:i+blockHeight, index(13)+blockWidth/2:end) = indexMean12;
end

imwrite(img1, 'C:\Users\Serissa\Desktop\1202\Pic_2017_12_02_095657_background.bmp');
figure;imshow(img1);

img2 = imread('C:\Users\Serissa\Desktop\1202\Pic_2017_12_02_100122_0.bmp');

image = img2 + img1;
imwrite(image, 'C:\Users\Serissa\Desktop\1202\Pic_2017_12_02_095657_0_2.bmp');
