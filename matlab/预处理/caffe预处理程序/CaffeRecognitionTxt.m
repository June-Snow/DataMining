%% 把图片转换成caffe需要的txt文件
%从一个文件夹中选择80%的样本作为训练样本，选择20%作为验证样本
%输入：包含训练样本的文件夹
%输出：生成caffe能够识别的txt文件

% path = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\pos\';
% img_path_list1 = dir([path,'*.jpg']);
% len1 = length(img_path_list1);
% imgName1 = cell(len1, 1);
% for i = 1 : len1
%     file_path1 = strcat(path, img_path_list1(i).name);
%     [~, name, ext] = fileparts(file_path1);
%     imgName1{i, 1} = strcat(name, ext);
% end
% 
% path = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\neg\';
% img_path_list2 = dir([path,'*.jpg']);
% len2 = length(img_path_list2);
% imgName2 = cell(len2, 1);
% for i = 1 : len2
%     file_path2 = strcat(path, img_path_list2(i).name);
%     [~, name2, ext] = fileparts(file_path2);
%     imgName2{i, 1} = strcat(name2, ext);
% end
% 
% savePath = 'C:\Users\Litao\Desktop\0909cloth\cnn\train\';
% saveTextPath = strcat(savePath, 'train.txt');
% train = fopen(saveTextPath,'wt');
% saveTextPath = strcat(savePath, 'test.txt');
% test = fopen(saveTextPath,'wt');
% len = min(len1, len2);
% for i =1 : len
%     if mod(i, 5) == 0
%         str = strcat('pos/', imgName1{i, 1}, '\t', num2str('1'), '\r');%
%         fprintf(test, str);
%         fprintf(test, '\n');%\r
%         str = strcat('neg/', imgName2{i, 1}, '\t', num2str('0'), '\r');%
%         fprintf(test, str);
%         fprintf(test, '\n');%\r
%     else
%         str = strcat('pos/', imgName1{i, 1}, '\t', num2str('1'), '\r');%\r
%         fprintf(train, str);
%         fprintf(train, '\n');%\r
%         str = strcat('neg/', imgName2{i, 1}, '\t', num2str('0'), '\r');%\r
%         fprintf(train, str);
%         fprintf(train, '\n');%\r
%     end
% end
% if(len1 > len2)
%     if mod(i, 5) == 0
%         str = strcat('pos/', imgName1{i, 1}, '\t', num2str('1'), '\r');%
%         fprintf(test, str);
%         fprintf(test, '\n');%\r
%     else
%         str = strcat('pos/', imgName1{i, 1}, '\t', num2str('1'), '\r');%\r
%         fprintf(train, str);
%         fprintf(train, '\n');%\r
%     end
% end
% if(len1 < len2)
%     if mod(i, 5) == 0
%         str = strcat('neg/', imgName2{i, 1}, '\t', num2str('0'), '\r');%
%         fprintf(test, str);
%         fprintf(test, '\n');%\r
%     else
%         str = strcat('neg/', imgName2{i, 1}, '\t', num2str('0'), '\r');%\r
%         fprintf(train, str);
%         fprintf(train, '\n');%\r
%     end
% end
% 
% fclose(train);
% fclose(test);
image_path = 'G:\leafDepth\20161216\360x640\';
save_path = 'G:\leafDepth\20161216\part\';
path = 'G:\leafDepth\20161216\360x640\训练分数.xls';
[data, name] =xlsread(path);
score = data(:, 3);
len = length(score(:, 1));
for i =1 : len
    image_name = name{i, 1};
    image = imread(strcat(image_path, image_name));
    
    image_score = score(i, 1);
    image_score = image_score + 0.00001;
    str = num2str(image_score);
    str = str(1:7);
    save_name = strcat(num2str(10000+i), '_', str);
    if mod(i, 3) == 0 %test
        imwrite(image, strcat(save_path, save_name, '.jpg'));
    end
    
end




savePath = 'G:\leafDepth\20161216\';
saveTextPath = strcat(savePath, 'train.txt');
train = fopen(saveTextPath,'wt');
saveTextPath = strcat(savePath, 'val.txt');
val = fopen(saveTextPath,'wt');
saveTextPath = strcat(savePath, 'test.txt');
test = fopen(saveTextPath,'wt');
len = length(score(:, 1));
for i =1 : len
    image_name = name{i, 1};
    image_score = score(i, 1);
    if mod(i, 6) == 0 %test
        str = strcat('360x640/', image_name, '\t', num2str(image_score), '\n');%
        fprintf(test, str);
        %fprintf(test, '\n');%\r
    elseif mod(i, 20) == 1 %val
        str = strcat('360x640/', image_name, '\t', num2str(image_score), '\n');%\r
        fprintf(val, str);
        %fprintf(train, '\n');%\r
    else %train
        str = strcat('360x640/', image_name, '\t', num2str(image_score), '\n');%\r
        fprintf(train, str);
        %fprintf(train, '\n');%\r
    end
end
fclose(train);
fclose(val);
fclose(test);
