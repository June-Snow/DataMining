%% 深度图片赋值
savePath = 'C:\Users\LiTao\Desktop\新建文件夹 (3)\深度图片\赋值图\';
path1 = 'C:\Users\LiTao\Desktop\新建文件夹 (3)\深度图片\原图\';%深度信息图片
img_path_list1 = dir([path1,'*.jpg']);
if isempty(img_path_list1);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len1 = length(img_path_list1);

path = 'C:\Users\LiTao\Desktop\新建文件夹 (3)\深度排序打分文件\';
excelPath = strcat(path, '分数5.xls');
if exist(excelPath, 'file')
    [strData1, strName1] = xlsread(excelPath);
    strData1 = (strData1-min(strData1))/(max(strData1) - min(strData1));
end
len2 = length(strData1);

data = zeros(10, 2);
for i = 1 : len1
    file_path1 = strcat(path1, img_path_list1(i).name);
    [~, name1, ext1] = fileparts(file_path1);
    name2 = name1(1: end-5);
    img = imread(file_path1);
    img(img == 1) = 255;
    for j = 1 : len2
        name = strName1{j};
        name = name(1: end-4);
        if ~isempty(strfind(name, name2))
            num = name(end-1:end);
            num = str2num(num);
            img(img == num) = strData1(j)*218+12;%赋值在12-230

        end
    end
    imwrite(img, strcat(savePath, name1, ext1));
    
end