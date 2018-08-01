% 马赛克
clear all;
clc;
close all;
condition = 0;
dir_path = ('C:\Users\LiTao\Desktop\新建文件夹\');
if condition == 0
    file_List = dir([dir_path, '*.jpg']);
else
    file_List = getAllFiles(dir_path);
    if isempty(file_List);
        error('设定的文件夹内没有任何视频，请重新检查...')
    end
end
len = length(file_List);
result = zeros(len, 2);
for i = 1 : len
    %% show the image.
    if condition == 0
        file = strcat(dir_path, file_List(i).name);
        image_name = file_List(i).name;
    else
        file = file_List{i};
        [pathstr, name, ext] = fileparts(file);
        image_name = strcat(num2str(i), '.bmp');
    end
    im = imread(file);
    w = fspecial('average',20);
    x = input('s');
    im = imresize(im, [720,1280]);
    while(x ~= 0)
        [imcroped, rect] = imcrop(im);
        rect = round(rect);
        [m, n, ~] = size(imcroped);
        d = 10;
        newI = [];
        newI = zeros(m + 2 * d, n + 2 * d, 3);       
        newI(d+1 : d+m, d+1 : d+n, 1 : 3) = imcroped; %中间部分       
        newI(1 : d, d+1 : d+n, 1 : 3) = imcroped(d : -1 : 1, : , 1 : 3); %上        
        newI(end-d : end, d+1 : d+n, 1 : 3) = imcroped(end : -1 : end-d, : , 1 : 3);%下        
        newI( : , 1 : d, 1 : 3) = newI( : , 2*d : -1 : d+1, 1 : 3);%左        
        newI( : , n+d+1 : n+2*d, 1 : 3) = newI( : , n+d : -1 : n+1, 1 : 3);%右

        im1 = newI(:, :, 1);
        im2 = newI(:, :, 2);
        im3 = newI(:, :, 3);
        K1=imfilter(im1,w);
        K2=imfilter(im2,w);
        K3=imfilter(im3,w);
        rgb_filtered=cat(3,K1,K2,K3);
        
        im(rect(2):rect(2)+rect(4), rect(1):rect(1)+rect(3),:) = rgb_filtered(end-10-rect(4):1:end-10,end-10-rect(3):1:end-10,:);
        x = input('s');
        
        
%         rect = round(rect);
%         [M, N, ~] = size(im);
%         top = rect(2)-10;
%         if top < 1
%             top = 1;
%         end
%         left = rect(1)-10;
%         if left < 1
%             left = 1;
%         end
%         %rect(2):rect(2)+rect(4), rect(1):rect(1)+rect(3)
%         down = rect(2)+rect(4)+10;
%         if down > M
%             down = M;
%         end
%         right = rect(1)+rect(3)+10;
%         if right > N
%             right = N;
%         end
%         im1 = im(top:down, left:right, 1);
%         im2 = im(top:down, left:right,2);
%         im3 = im(top:down, left:right,3);
%         K1=imfilter(im1,w);
%         K2=imfilter(im2,w);
%         K3=imfilter(im3,w);
%         rgb_filtered=cat(3,K1,K2,K3);
%         
%         im(rect(2):rect(2)+rect(4), rect(1):rect(1)+rect(3),:) = rgb_filtered(end-10:-1:end-10-rect(4),end-10:-1:end-10-rect(3),:);
%         x = input('s');
    end
    figure;
    imshow(im);
    image_name = strcat('0', image_name);
    imwrite(im, strcat(dir_path, image_name));
    close all;
end



