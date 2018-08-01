%% 把图片转换成caffe需要的txt文件
%从一个文件夹中选择80%的样本作为训练样本，选择20%作为验证样本
%输入：包含训练样本的文件夹
%输出：生成caffe能够识别的txt文件

% path1 = 'F:\caffe-windows-master\data\0909cloth\cnn\train\pos\';
% img_path_list1 = dir([path1,'*.jpg']);
% len1 = length(img_path_list1);
% imgName1 = cell(len1, 1);
% for i = 1 : len1
%     file_path1 = strcat(path1, img_path_list1(i).name);
%     [~, name, ext] = fileparts(file_path1);
%     imgName1{i, 1} = strcat(name, ext);
% end
% 
% path2 = 'F:\caffe-windows-master\data\0909cloth\cnn\train\neg\';
% img_path_list2 = dir([path2,'*.jpg']);
% len2 = length(img_path_list2);
% imgName2 = cell(len2, 1);
% for i = 1 : len2
%     file_path2 = strcat(path2, img_path_list2(i).name);
%     [~, name, ext] = fileparts(file_path2);
%     imgName2{i, 1} = strcat(name, ext);
% end
% 
% path = 'F:\caffe-windows-master\data\0909cloth\cnn\train\';
% saveTextPath = strcat(path, 'train.txt');
% train = fopen(saveTextPath,'wt');
% saveTextPath = strcat(path, 'test1.txt');
% test1 = fopen(saveTextPath,'wt');
% saveTextPath = strcat(path, 'test2.txt');
% test2 = fopen(saveTextPath,'wt');
% 
% len = min(len1, len2);
% for i =1 : len
%     if mod(i, 5) == 0
%         str1 = strcat('pos/', imgName1{i, 1}, '\t', num2str('1'), '\r');%
%         fprintf(test1, str1);
%         fprintf(test1, '\n');%\r
%         str2 = strcat('neg/', imgName2{i, 1}, '\t', num2str('0'), '\r');%
%         fprintf(test1, str2);
%         fprintf(test1, '\n');%\r
%     else
%         str1 = strcat('pos/', imgName1{i, 1}, '\t', num2str('1'), '\r');%\r
%         fprintf(train, str1);
%         fprintf(train, '\n');%\r
%         str2 = strcat('neg/', imgName2{i, 1}, '\t', num2str('0'), '\r');%\r
%         fprintf(train, str2);
%         fprintf(train, '\n');%\r
%     end
% end
% for i =len : max(len1, len2)
%     if mod(i, 5) == 0
%         str1 = strcat('pos/', imgName1{i, 1}, '\t', num2str('1'), '\r');%
%         fprintf(test1, str1);
%         fprintf(test1, '\n');%\r
%     else
%         str1 = strcat('pos/', imgName1{i, 1}, '\t', num2str('1'), '\r');%\r
%         fprintf(train, str1);
%         fprintf(train, '\n');%\r
%     end
% end
% fclose(train);
% fclose(test1);
% fclose(test2);


