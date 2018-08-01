function batCrop(image, name, ext, labelPath, cutPath)
%%
%ѡ��ͼƬ���ض�λ�õ���Ҷ�����ú�ɫ�����ʾ
%�������ɫ�����е�ͼƬ
%��������ȡͼ���е���Ҷ�飬��ȡͼ�����������ԭʼͼ���б���
%���룺0����ʾ�����Ե�ǰͼ����м�����ȡ�ֿ飻
%     1����ʾ��ǰ��ȡ�ķֿ�����һ�ν�ȡ�Ŀ������ͬ�����Ϣ����Ҷ�飻
%     2����ʾ��ǰ��ȡ�ķֿ�����һ�ν�ȡ�Ŀ���в�ͬ�������Ϣ����Ҷ�飻

%����������ԭʼͼ����е������ȡ�����ľ�������

tageImage = rgb2gray(image);
tageImage(:, :) = 1;%���ͼƬ��ʼֵΪ1
x = input('s');%x=0ͼƬ�ֿ��Ƿ������x=1�뵱ǰ�����ͬ����Ҷ��x=2�뵱ǰ�������һ�β�ͬ����Ҷ
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
        if x == 2 %���벻ͬ��x����img���¸�ֵ            
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
        
        %����ֿ�ͼƬ
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
%��ɫ����ͼƬ
img(point(2):point(2)+2, point(1):point(1)+point(3), :) = 0;
img(point(2):point(2)+2, point(1):point(1)+point(3), 1) = 255;

img(point(2)+point(4)-2:point(2)+point(4), point(1):point(1)+point(3), :) = 0;
img(point(2)+point(4)-2:point(2)+point(4), point(1):point(1)+point(3), 1) = 255;

img(point(2):point(2)+point(4), point(1):point(1)+2, :) = 0;
img(point(2):point(2)+point(4), point(1):point(1)+2, 1) = 255;

img(point(2):point(2)+point(4), point(1)+point(3)-2:point(1)+point(3), :) = 0;
img(point(2):point(2)+point(4), point(1)+point(3)-2:point(1)+point(3), 1) = 255;

end


