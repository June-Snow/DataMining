function batCrop(image, filename, ext, sourcePath, cutPath)
%%
%ѡ��ͼƬ���ض�λ�õ���Ҷ�����ú�ɫ�����ʾ
%�������ɫ�����е�ͼƬ

x = input('s');
i = 0;
while(x ~= 0)
    [imcroped, point] = imcrop(image);
    point = floor(point);
    %filename = strcat(filename, num2str(i));
    newName = strcat(filename, '_', num2str(i), ext);
    if ~isempty(imcroped)
        path = strcat(cutPath, newName);
        
        sourcePath = strcat(sourcePath, newName);
%         image(point(2)+1:point(2)+3, point(1)+1:point(1)+point(3), :) = 0;
%         image(point(2)+1:point(2)+3, point(1)+1:point(1)+point(3), 1) = 255;
%         
%         image(point(4)-2:point(4), point(1)+1:point(1)+point(3), :) = 0;
%         image(point(4)-2:point(4), point(1)+1:point(1)+point(3), 1) = 255;
%         
%         image(point(2)+1:point(2)+point(4), point(1)+1:point(1)+3, :) = 0;
%         image(point(2)+1:point(2)+point(4), point(1)+1:point(1)+3, 1) = 255;
%         
%         image(point(2)+1:point(2)+point(4), point(1)+point(3)-2:point(1)+point(3), :) = 0;
%         image(point(2)+1:point(2)+point(4), point(1)+point(3)-2:point(1)+point(3), 1) = 255;
        %figure; imshow(image);
        imwrite(imcroped, path);
        %imwrite(image, sourcePath);
    end
    x = input('s');
    i = i + 1;
end

end




