%% ����Excel�ļ���ͼƬ���򣬰�ͼƬ���ָĳ�name+score�ĸ�ʽ
if 0
image_path = 'E:\caffe-windows-master\data&models\FCN-Leaf\��������\train\';
save_path = 'E:\caffe-windows-master\data&models\FCN-Leaf\��������\trainImage\';
imageLabel_path = 'E:\caffe-windows-master\data&models\FCN-Leaf\��������\trainLabel\';
saveLabel_path = 'E:\caffe-windows-master\data&models\FCN-Leaf\��������\trainImageLabel\';
path = 'E:\caffe-windows-master\data&models\FCN-Leaf\��������\train\�ڵ�����5.xls';
[data, name] =xlsread(path);
score = data(:, 2);
len = length(score(:, 1));
for i =1 : len
    image_name = name{i, 1};
    image = imread(strcat(image_path, image_name));
    image_score = score(i, 1);
    str = num2str(image_score);
    if length(str) < 7
        str = strcat(str, '11111111');
    end
    str = str(1:7);
    save_name = strcat(num2str(10000+i), '_', str);
    %if mod(i, 3) == 0 %test
        imwrite(image, strcat(save_path, save_name, '.jpg'));
    %end
    labelName = image_name(1:end-3);
    labelName = strcat(labelName, 'png');
    imageabel = imread(strcat(imageLabel_path, labelName));
    imwrite(imageabel, strcat(saveLabel_path, save_name, '.png'));
end
end
%% �����ݼ��ֳ�ѵ��������֤���Ͳ��Լ�
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