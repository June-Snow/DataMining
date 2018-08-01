%%
%调整深度信息图片尺寸大小，使其适合四中不同训练图片尺寸要求
%常见图片尺寸有：576*720、720*1280、1080*1920、1536*2048
%对应训练尺寸有：192*240、240*426、360*640、512*682
path = 'C:\Users\LiTao\Desktop\新建文件夹 (5)\';%深度信息图片
savePath = 'C:\Users\LiTao\Desktop\新建文件夹 (5)\';
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len = length(img_path_list);

resizeImage = [[192, 240];[240, 426];[360, 640];[512, 682]];
for i = 1 : 1
    width = resizeImage(i, 2);
    height = resizeImage(i, 1);
    partPath = strcat(savePath, num2str(height), 'x', num2str(width), '\');
    mkdir(partPath);
    for j = 1 : len
        file_path = strcat(path, img_path_list(j).name);
        [~, name, ext] = fileparts(file_path);
        name = strcat(name, '_');
        if exist(file_path, 'file')
            image = imread(file_path);
            ChangePictureSize(image, partPath, width, height, name);
        end
    end
    
end




