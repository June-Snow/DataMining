function batCrop(image, name, ext, cutPath)
%%
%输出：保存对原始图像进行的区域截取操作的矩形区域；
blockSize = 93;
[M, N, ~] = size(image);
x = input('s');%x=0图片分块是否继续
num = 0;
while(x ~= 0)
    [imcroped, point] = imcrop(image);
    point = ceil(point);
    startCol = point(1);
    startRow = point(2);    
    if ~isempty(imcroped)
        newName = strcat(name, '_', num2str(num), ext);
        cropedPath = strcat(cutPath, newName);
        if startCol+blockSize > N
            startCol = N - blockSize;
        end
        if startRow+blockSize > M
            startRow = M - blockSize;
        end
        imcroped = image(startRow:startRow+blockSize-1, startCol:startCol+blockSize-1, :);
        imwrite(imcroped, cropedPath);
        num = num + 1;
    end
    x = input('s');
end
end



