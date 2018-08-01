%% 验证测试：把图片转换成caffe需要的txt文件
%文件夹中所有样本作为验证测试样本
%输入：包含验证测试样本的文件夹
%输出：生成caffe能够识别的txt文件

path = 'C:\Users\Litao\Desktop\aeroplane\label\';
img_path_list1 = dir([path,'*.png']);
len1 = length(img_path_list1);
imgName = cell(len1, 1);
for i = 1 : len1
    file_path1 = strcat(path, img_path_list1(i).name);
    [~, name, ext] = fileparts(file_path1);
    imgName{i, 1} = strcat(name, ext);
end

saveTextPath = strcat(path, 'train.txt');
test = fopen(saveTextPath,'wt');

for i =1 : len1
    str = strcat(imgName{i, 1},  '\r');%'\t', num2str('1'),
    fprintf(test, str);
    fprintf(test, '\n');%\r
end
fclose(test);