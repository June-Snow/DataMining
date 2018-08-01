%%
%选择图片中特定位置的树叶区域用红色方框表示，树叶指的并非只是树叶还包括绿色草坪
%以此作为深度信息进行排序打分的依据


path = 'F:\caffe-windows-master\data\0909cloth\cnn\train\crop\有缺陷小图\';%%ps文件
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len = length(img_path_list);
cutPath = 'F:\caffe-windows-master\data\0909cloth\cnn\train\neg\';%保存截取图像

for i=2 : len
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    if exist(file_path, 'file')
        image = imread(file_path);
%         [M, N, ~] = size(image);
%         image1 = image(1:round(M/2)+40, 1:round(N/2)+40, :);
%         image2 = image(1:round(M/2)+40, round(N/2)-40:end, :);
%         image3 = image(round(M/2)-40:end, 1:round(N/2)+40, :);
%         image4 = image(round(M/2)-40:end, round(N/2)-40:end, :);
%         imwrite(image1, strcat(cutPath, name, '_0', ext));
%         imwrite(image2, strcat(cutPath, name, '_1', ext));
%         imwrite(image3, strcat(cutPath, name, '_2', ext));
%         imwrite(image4, strcat(cutPath, name, '_3', ext));
        batCrop(image, name, ext, cutPath)
    end
end

