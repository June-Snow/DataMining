%%
%选择图片中特定位置的树叶区域用红色方框表示，树叶指的并非只是树叶还包括绿色草坪
%以此作为深度信息进行排序打分的依据


path = 'C:\Users\LiTao\Desktop\新建文件夹 (4)\';%%ps文件
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len = length(img_path_list);
sourcePath = strcat(path,'源文件\');%保存原始图像，原始图像会保留截取图像时留下的矩形框
cutPath = strcat(path,'剪切文件\');%保存截取图像
mkdir(sourcePath);
mkdir(cutPath);

for i=1 : len
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    if exist(file_path, 'file')
        image = imread(file_path);
        
        batCrop(image, name, ext, sourcePath, cutPath)
    end
end

