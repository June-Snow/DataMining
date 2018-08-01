%% 图片中间标注数字
% img = imread('C:\Users\LiTao\Desktop\新建文件夹 (4)\3008859.jpg');
% [M, N, ~] = size(img);
% if M >= 720 && N >= 1280
%     img = imresize(img, [720 1280]);
%     M = 720;
%     N = 1280;
% end
% img(:, 1:4, :) = 0;
% img(:, N-3:N, :) = 0;
% img(1:6, :, :) = 0;
% img(M-3:M, :, :) = 0;
% for i = 1 : 2
%     img(round(M/3*i):round(M/3*i)+1, :, 2:3) = 0;
%     img(round(M/3*i):round(M/3*i)+1, :, 1) = 255;
% end
% for j = 1 : 2
%     img(:, round(N/3*j):round(N/3*j)+1, 2:3) = 0;
%     img(:, round(N/3*j):round(N/3*j)+1, 1) = 255;
% end
% figure;imshow(img);
% classNum = [0.052007, 0.10475, 0.66792,...
%             0.075146, 0, 0,...
%             0.094395, 0,0];
% for i = 1 : 3
%     for j = 1 : 1
%         text(round((2*(j-1)+1)*N/6), round((2*(i-1)+1)*M/6), num2str(classNum((i-1)*3+j)), 'horiz', 'center','color','r', 'fontsize', 25);
%     end
% end
% for i = 1 : 1
%     for j = 1 : 3
%         text(round((2*(j-1)+1)*N/6), round((2*(i-1)+1)*M/6), num2str(classNum((i-1)*3+j)), 'horiz', 'center','color','r', 'fontsize', 25);
%     end
% end


%% 图片中间标注文字
img = imread('C:\Users\LiTao\Desktop\新建文件夹\001900000155.jpg');
 [M, N, ~] = size(img);
 
if M >= 720 && N >= 1280
    img = imresize(img, [720 1280]);
    M = 720;
    N = 1280;
end
img(:, 1:4, :) = 0;
img(:, N-3:N, :) = 0;
img(1:6, :, :) = 0;
img(M-3:M, :, :) = 0;
%figure;imshow(img);
imwrite(img, 'C:\Users\LiTao\Desktop\新建文件夹\001900000155_gray.jpg');

for i = 1 : 2
    img(round(M/3*i):round(M/3*i)+1, :, 2:3) = 0;
    img(round(M/3*i):round(M/3*i)+1, :, 1) = 255;
end
for j = 1 : 2
    img(:, round(N/3*j):round(N/3*j)+1, 2:3) = 0;
    img(:, round(N/3*j):round(N/3*j)+1, 1) = 255;
end
figure;imshow(img);

classNum(:,:)= {'NAN', 'NAN', 'NAN';... 
            'NAN', 'NAN', 'NAN';...
            'NAN', 'NAN', 'NAN'};
classNum = classNum';        
for i = 1 : 3
    for j = 1 : 3
        text(round((2*(j-1)+1)*N/6), round((2*(i-1)+1)*M/6), ...
            (classNum((i-1)*3+j)), 'horiz', 'center','color','r', 'fontsize', 50);
    end
end
