clear cll;
clc;
%% 生成fcn相关的train.txt和val.txt
path1 = 'E:\caffe-windows-master\data&models\FCN-Leaf\LeafOcclusion\onlyLeafImage\onlyLeafImage\';
img_path_list1 = dir([path1,'*.bmp']);
len1 = length(img_path_list1);
imgName1 = cell(len1, 1);
meanR = 0;
meanG = 0;
meanB = 0;
for i = 1 : len1
    file_path1 = strcat(path1, img_path_list1(i).name);
    [~, name, ext] = fileparts(file_path1);
    imgName1{i, 1} = name;
    
    img = imread(file_path1);
    imgR = img(:, :, 1);
    imgG = img(:, :, 2);
    imgB = img(:, :, 3);
    meanR = meanR + mean(mean(imgR));
    meanG = meanG + mean(mean(imgG));
    meanB = meanB + mean(mean(imgB));
end
meanR = meanR/len1;
meanG = meanG/len1;
meanB = meanB/len1;
path = 'E:\caffe-windows-master\data&models\FCN-Leaf\SegmentationTxt\';
saveTextPath = strcat(path, 'meanRGB.txt');
meanRGB = fopen(saveTextPath,'wt');
str1 = strcat('meanR:', num2str(meanR), ' ', '\n', 'meanG:', num2str(meanG), ' ', '\n', 'meanB:', num2str(meanB), ' ', '\n');%
fprintf(meanRGB, str1);
fclose(meanRGB);        
        
path = 'E:\caffe-windows-master\data&models\FCN-Leaf\SegmentationTxt\';
saveTextPath = strcat(path, 'train.txt');
train = fopen(saveTextPath,'wt');

path = 'E:\caffe-windows-master\data&models\FCN-Leaf\SegmentationTxt\';
saveTextPath = strcat(path, 'val.txt');
val = fopen(saveTextPath,'wt');

path = 'E:\caffe-windows-master\data&models\FCN-Leaf\SegmentationTxt\';
saveTextPath = strcat(path, 'test.txt');
test = fopen(saveTextPath,'wt');

count = 1;
for i =1 : len1
    if count <= 7
        str1 = strcat(imgName1{i, 1}, ' ', '\n');%
        fprintf(train, str1);
        count = count + 1;
    elseif count<= 9
        str1 = strcat(imgName1{i, 1}, ' ', '\n');%
        fprintf(val, str1);
        count = count + 1;
    else
        str1 = strcat(imgName1{i, 1}, ' ', '\n');%
        fprintf(test, str1);
        count = 1;
    end
end
fclose(val);
fclose(train);
fclose(test);
