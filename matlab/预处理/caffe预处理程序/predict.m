%% 把原始图像截成BLOCKWIDTH*BLOCKWIDTH的小块
excelPath = 'C:\Users\Litao\Desktop\0909cloth\cnn\test\10x0300FCF1526061F35_50000predict_result.xls';
if exist(excelPath, 'file')
    [strData, strName] = xlsread(excelPath);
    num = strData(:, 3);
end

image = imread('C:\Users\Litao\Desktop\0909cloth\cnn\test\10x0300FCF1526061F35.jpg');

for i = 1 : length(strName)
    if num(i) < 0.2
        name = strName{i};
        name = name(1 : end-4);
        str = regexp(name, '_', 'split');
        row = str2num(str{2});
        col = str2num(str{3});
        image(row:row+2, col:col+99, :) = 0;
        image(row:row+2, col:col+99, 1) = 255;
        image(row+97:row+99, col:col+99, :) = 0;
        image(row+97:row+99, col:col+99, 1) = 255;
        
        image(row:row+99, col:col+2, :) = 0;
        image(row:row+99, col:col+2, 1) = 255;
        image(row:row+99, col+97:col+99, :) = 0;
        image(row:row+99, col+97:col+99, 1) = 255;
    end
    
end

imwrite(image, 'C:\Users\Litao\Desktop\0909cloth\cnn\test\10x0300FCF1526061F35_50000predict_result_0.2.jpg');
