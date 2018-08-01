clear all;
clc;
imgPath = 'C:\Users\Serissa\Desktop\Ê÷Ò¶ÕÚµ²Í¼Æ¬\';
savePath1 = 'C:\Users\Serissa\Desktop\test1\';
savePath2 = 'C:\Users\Serissa\Desktop\test2\';
textPath = 'C:\Users\Serissa\Desktop\Ê÷Ò¶ÕÚµ²Í¼Æ¬\Ê÷Ò¶ÕÚµ²Í¼Æ¬¶ÔÓ¦·ÖÊý.xlsx';
[imgData, imgName] = xlsread(textPath);
len = length(imgData);
imgData1 = cell(145, 2);
imgData2 = cell(145, 2);
k1 = 1;
k2 = 1;
for i =1 : len
    name1 = imgName{i, 1};
    name1 = strrep(name1, 'avi', 'jpg');
    name2 = name1;
    sourcePath = strcat(imgPath,name1);
    if mod(i, 5) == 0
        if mod(i, 5) == 0 && mod(i, 10) ~= 0 
            imgData1{k1, 1} = imgName{i, 1};
            imgData1{k1, 2} = imgData(i, 1);
            k1 = k1 + 1;
            if exist(sourcePath, 'file')
                movefile(sourcePath, strcat(savePath1, name2, '.jpg'));
            end
        end
        if mod(i, 10) == 0 
            imgData2{k2, 1} = imgName{i, 1};
            imgData2{k2, 2} = imgData(i, 1);
            k2 = k2 + 1;
            if exist(sourcePath, 'file')
                movefile(sourcePath, strcat(savePath2, name2, '.jpg'));
            end
        end
    end
end
xlswrite(strcat(savePath1, 'Ê÷Ò¶ÕÚµ²Í¼Æ¬¶ÔÓ¦·ÖÊý.xlsx'), imgData1, 'Sheet1');
xlswrite(strcat(savePath2, 'Ê÷Ò¶ÕÚµ²Í¼Æ¬¶ÔÓ¦·ÖÊý.xlsx'), imgData2, 'Sheet1');







