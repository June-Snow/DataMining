function batCrop(img, name, ext, saveDir)
%%
%saveDir = 'C:\Users\litao\Desktop\³¬ÏñËØ';
if ~exist(saveDir, 'dir')
    mkdir(saveDir);
end
[M, N, ~] = size(img);
x = input('s');
i = 0;
while(x ~= 0)
    rowStart = 1;
    rowEnd = 1;
    colStart = 1;
    colEnd = 1;
    [imcroped, index] = imcrop(img);%index×ø±ê£¨x,y, w,h£©
    filename = strcat(name, '_', num2str(i));
    newName = [filename, ext];
    if ~isempty(imcroped)
        saveImg = strcat(saveDir, newName);
        rowStart = ceil(index(2));
        rowEnd = ceil(index(2))+83;
        if(rowEnd > M)
            rowStart = M - 83;
            rowEnd = M;
        end
        colStart = ceil(index(1));
        colEnd = ceil(index(1))+83;
        if(colEnd > N)
            colStart = N - 83;
            colEnd = N;
        end
        cropImg = img(rowStart:rowEnd, colStart:colEnd, :);
        imwrite(cropImg, saveImg);
    end
    x = input('s');
    i = i + 1;
    %img(ceil(index(2)):ceil(index(2))+ceil(index(4)), ceil(index(1)):ceil(index(1))+ceil(index(3)), :) = 255;
    %img(rowStart:rowEnd, colStart:colEnd, :) = 255;
end
if i~= 1
    %imwrite(img, saveImg);
end

end
