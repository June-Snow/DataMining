%% 转换成生成proto的txt文件

% textPath = 'H:\leaf-cnn\classification\deeplearning\leafOcclusion\data\分数.xlsx';
% [imgData, imgName] = xlsread(textPath);
% imgData = imgData(:, 1);
% len = length(imgName(:, 1));
% saveTextPath = 'H:\leaf-cnn\classification\deeplearning\leafOcclusion\data\train.txt';
% train = fopen(saveTextPath,'wt');
% saveTextPath = 'H:\leaf-cnn\classification\deeplearning\leafOcclusion\data\test.txt';
% test = fopen(saveTextPath,'wt');
% MIN = min(imgData);
% MAX = max(imgData);
% for i =1 : len
%     if mod(i, 5) == 0
%         str = strcat(imgName{i, 1}, '\t', num2str((imgData(i, 1)-MIN)/(MAX-MIN)), '\r');%
%         fprintf(test, str);
%         fprintf(test, '\n');%\r
%     else
%         str = strcat(imgName{i, 1}, '\t', num2str((imgData(i, 1)-MIN)/(MAX-MIN)), '\r');%\r
%         fprintf(train, str);
%         fprintf(train, '\n');%\r
%     end
% end
% fclose(train);
% fclose(test);


saveTextPath = 'E:\leafOcclusion\b-Part2-1080p\train.txt';
train = fopen(saveTextPath,'wt');
saveTextPath = 'E:\leafOcclusion\b-Part2-1080p\test.txt';
test = fopen(saveTextPath,'wt');

path = 'E:\leafOcclusion\b-Part2-1080p\';
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len = length(img_path_list);

for i=1 : len
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    
%    if mod(i, 5) == 0
        str = strcat(name, ext, '\t', '1', '\r');
        fprintf(test, str);
        fprintf(test, '\n');
%     else
%         str = strcat(name, ext, '\t', num2str(0.95+(i/len)*0.05), '\r');
%         fprintf(train, str);
%         fprintf(train, '\n');
%     end
end
fclose(train);
fclose(test);


