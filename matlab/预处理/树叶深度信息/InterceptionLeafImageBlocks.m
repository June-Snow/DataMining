%% 
%操作：截取图像中的树叶块，截取图像块的区域会在原始图像中保存
%输入：0：表示放弃对当前图像进行继续截取分块；
%     1：表示当前截取的分块与上一次截取的块具有相同深度信息的树叶块；
%     2：表示当前截取的分块与上一次截取的块具有不同的深度信息的树叶块；

%输出：保存对原始图像进行的区域截取操作的矩形区域；

path = 'C:\Users\LiTao\Desktop\新建文件夹 (5)\';%图片
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len = length(img_path_list);

for j = 1 : len
    file_path = strcat(path, img_path_list(j).name);
    [~, name, ext] = fileparts(file_path);
    %name = name(1:end-6);
    x = input('s');%x=0图片分块是否继续，x=1与当前深度相同的树叶，x=2与当前深度与上一次不同的树叶
    image = imread(file_path);
    [m, n] = size(image);
    img = image;
    while(x ~= 0)
        [imcroped, point] = imcrop(image);
        point = ceil(point);
        row = point(2);
        col = point(1);
        
        num = 0;% 计算向下滑动的距离
        for i = row : m
            if img(i, col) == 255 
                num = num + 1;          
            else
                down = i;
            end
            if num > 10
                break;
            end
        end
        
        num = 0;% 计算向上滑动的距离
        for i = row : -1: 1
            if img(i, col) == 255 
                num = num + 1;   
            else
                up = i;
            end
%             if img(i, col) == img(row, col)
%                 up = i;
%             else
%                 num = num + 1;   
%             end
            if num > 10
                break;

            end            
        end        
         num = 0;% 计算向左滑动的距离
        for i = col : -1: 1
            if img(row, i) == 255 
                num = num + 1;   
            else
                left = i;
            end
            if num > 10
                break;
            end            
        end   
         num = 0;% 计算向右滑动的距离
        for i = col : n
            if img(row, i) == 255 
                num = num + 1;   
            else
                right = i;
            end
            if num > 10
                break;
            end            
        end   
        img(up:down+1, left:right) = img(row, col);
         %figure;imshow(img);
        x = input('s');        
    end
    imwrite(img, strcat(path, name, ext));    
end








