%RGB
% [data1, ~] = xlsread('1.xlsx');
% dataSum = sum(data1(:, 4));
% dataNum = zeros(255, 3);
% for i = 1 : 255
%     index1 = find(data1(:, 1) == i);
%     dataNum(i, 1) = sum(data1(index1, 4));
%     index2 = find(data1(:, 2) == i);
%     dataNum(i, 2) = sum(data1(index2, 4));
%     index3 = find(data1(:, 3) == i);
%     dataNum(i, 3) = sum(data1(index3, 4));
% end
% plot(1:255, dataNum(:, 1)/dataSum, '-r',1:255, dataNum(:, 2)/dataSum, ':g',1:255, dataNum(:, 3)/dataSum, '--b');
% legend('-r', '.g', '--b');

% scatter3(x(1:100), y(1:100), z(1:100), '.');
% xlabel('R');
% ylabel('G');
% zlabel('B');
% view(65,-10);
%HSV
[data1, num] = xlsread('1.xlsx');
x = data1(:, 1);
y = data1(:, 2);
z = data1(:, 3);
hsv = rgb2hsv(x, y, z);
hsv(:, :, 3) = hsv(:, :, 3)/255;
path = 'C:\Users\LiTao\Desktop\新建文件夹\';
img_path_list = dir([path,'*.jpg']);
len = length(img_path_list);

for i = 1 : len
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    img = imread(file_path);
    img = rgb2hsv(img);
    [m, n, ~] = size(img);
    img = imresize(img,[m*0.1, n*0.1]);
    [m, n, ~] = size(img);
    for j = 1 : m
        for k = 1 :n
            pix = img(j, k, :);
            [rx, cx] = find(abs(hsv(:, :, 1) - pix(1,1,1)) < 0.0005);
            [ry, cy] = find(abs(hsv(:, :, 2) - pix(1,1,2)) < 0.0005);
            [rz, cz] = find(abs(hsv(:, :, 3) - pix(1,1,3)) < 0.0005);
            if ~isempty(rx) && ~isempty(ry) && ~isempty(rz)
                pos = intersect(rx, ry);
                pos = intersect(pos, rz);
                if isempty(pos)
                    img(j, k, :) = 0;
                end
            else
                img(j, k, :) = 0;
            end
        end
    end
    imwrite(img, strcat(path, name, '0', ext));
end

%% 画RGB三色图
% path1 = 'E:\leafOcclusion\颜色分析文件\originalImage\';
% path = 'E:\leafOcclusion\颜色分析文件\seg_result\';
% img_path_list = dir([path,'*.jpg']);
% len = length(img_path_list);
% data = [0.0, 0.0, 0.0, 0.0];
% for i = 1 : len
%     file_path = strcat(path, img_path_list(i).name);
%     [~, name, ext] = fileparts(file_path);
%     img = imread(file_path);
%     [row, col] = find(img == 255);
%     image = imread(strcat(path1, name, ext));
%     for j = 1 : length(row)
%         pix = image(row(j), col(j), :);
%         x = pix(:, :, 1) + 1;
%         y = pix(:, :, 2) + 1;
%         z = pix(:, :, 3) + 1;
%         [rx, cx] = find(data(:, 1) == x);
%         [ry, cy] = find(data(:, 2) == y);
%         [rz, cz] = find(data(:, 3) == z);
%         if ~isempty(rx) && ~isempty(ry) && ~isempty(rz)
%             pos = intersect(rx, ry);
%             pos = intersect(pos, rz);
%             if ~isempty(pos)
%                 data(pos, 4) = data(pos, 4) + 1;
%             else
%                 val = [x, y, z, 1];
%                 val = double(val);
%                 data = [data; val];
%             end
%             
%         else
%             val = [x, y, z, 1];
%             val = double(val);
%             data = [data; val];
%         end
%     end
% end
 



