%% ��֤���ԣ���ͼƬת����caffe��Ҫ��txt�ļ�
%�ļ���������������Ϊ��֤��������
%���룺������֤�����������ļ���
%���������caffe�ܹ�ʶ���txt�ļ�

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