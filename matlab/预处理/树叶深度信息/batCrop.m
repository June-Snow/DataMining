function batCrop(image, name, ext, labelPath, cutPath)
%%
%选择图片中特定位置的树叶区域用红色方框表示
%并保存红色方框中的图片
%操作：截取图像中的树叶块，截取图像块的区域会在原始图像中保存
%输入：0：表示放弃对当前图像进行继续截取分块；
%     1：表示当前截取的分块与上一次截取的块具有相同深度信息的树叶块；
%     2：表示当前截取的分块与上一次截取的块具有不同的深度信息的树叶块；

%输出：保存对原始图像进行的区域截取操作的矩形区域；

tageImage = rgb2gray(image);
tageImage(:, :) = 1;%深度图片初始值为1
x = input('s');%x=0图片分块是否继续，x=1与当前深度相同的树叶，x=2与当前深度与上一次不同的树叶
depth = 10;
num = 0;
img = image;
flage = 0;
while(x ~= 0)
    [imcroped, point] = imcrop(image);
    point = ceil(point);
    
    if ~isempty(imcroped)
        flage = 1;
        filename = strcat(name, '_', num2str(depth));
        sourcePath = strcat(labelPath, strcat(filename, ext));
        if x == 2 %输入不同的x，对img重新赋值            
            imwrite(img, sourcePath);
            
            img = image;
            num = 0;
            depth = depth + 1;
            filename = strcat(name, '_', num2str(depth));
            sourcePath = strcat(labelPath, strcat(filename, ext));
            img = redBox(img, point);
        elseif x == 1
            img = redBox(img, point);
        end
        
        %保存分块图片
        tageImage(point(2):point(2)+point(4), point(1):point(1)+point(3)) = depth;
        newName = strcat(filename, '_', num2str(num), ext);
        cropedPath = strcat(cutPath, newName);
        imwrite(imcroped, cropedPath);
        num = num + 1;
    end
    x = input('s');
    
end
if ~isempty(img) && flage
    imwrite(img, sourcePath);
    imwrite(tageImage, strcat(labelPath, name, '_depth',  ext));
end

end

function img = redBox(img, point)
%红色方框图片
img(point(2):point(2)+2, point(1):point(1)+point(3), :) = 0;
img(point(2):point(2)+2, point(1):point(1)+point(3), 1) = 255;

img(point(2)+point(4)-2:point(2)+point(4), point(1):point(1)+point(3), :) = 0;
img(point(2)+point(4)-2:point(2)+point(4), point(1):point(1)+point(3), 1) = 255;

img(point(2):point(2)+point(4), point(1):point(1)+2, :) = 0;
img(point(2):point(2)+point(4), point(1):point(1)+2, 1) = 255;

img(point(2):point(2)+point(4), point(1)+point(3)-2:point(1)+point(3), :) = 0;
img(point(2):point(2)+point(4), point(1)+point(3)-2:point(1)+point(3), 1) = 255;

end


