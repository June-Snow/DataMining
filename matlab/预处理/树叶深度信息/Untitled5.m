%% ELO最优迭代次数统计

% path = 'C:\Users\LiTao\Desktop\ELO迭代次数\';
% len = 1500;
% for i = 1 : 10
%     ELOiterater(path, len);
% end

%% 打分文件排序SROCC数值统计

% path = 'E:\leafOcclusion\b-Part2-leaf\';
% sroccNum = ELORatingSROOC(path);

%% 画3X5的15宫格
% path = 'C:\Users\LiTao\Desktop\树叶遮挡\';
% img_path_list = dir([path,'*.jpg']);
% if isempty(img_path_list);
%     error('设定的文件夹内没有任何视频，请重新检查...')
% end
% len = length(img_path_list);
% path2 = 'C:\Users\LiTao\Desktop\新建文件夹\';
% for i=1 : len
%     file_path = strcat(path, img_path_list(i).name);
%     [~, name, ext] = fileparts(file_path);
%     if exist(file_path, 'file')
%         image = imread(file_path);
%         [M, N, ~] = size(image);
%         image(round(M/3): round(M/3)+1, :, 1) = 255;
%         image(round(2*M/3): round(2*M/3)+1, :, 1) = 255;
%         
%         image(:, round(N/5): round(N/5)+1, 1) = 255;
%         image(:, round(2*N/5): round(2*N/5)+1, 1) = 255;
%         image(:, round(3*N/5): round(3*N/5)+1, 1) = 255;
%         image(:, round(4*N/5): round(4*N/5)+1, 1) = 255;
%         imwrite(image, [path2, name, ext]);
%     end
% end

%% 把图片中红色字体该成白色字体
path = 'C:\Users\Serissa\Desktop\新建文件夹\';
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len = length(img_path_list);
path2 = 'C:\Users\Serissa\Desktop\新建文件夹 (2)\';
for i=1 : len
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    if exist(file_path, 'file')
        image = imread(file_path);
        [M, N, ~] = size(image);
        for j = 1 : M
            for k = 1 : N
                if (image(j, k, 1) > 180)
                    image(j, k, :) = 255;
                end
            end
        end
        figure;
        imshow(image);
        imwrite(image, [path2, name, ext]);
    end
end