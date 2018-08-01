%% 把原始图像截成48*48的小块
saveDir = 'C:\Users\Serissa\Desktop\83X83\pos\';
dir_name = 'C:\Users\Serissa\Desktop\正样本\';
file_name = dir([dir_name, '*.jpg']);
for i = 1 : length(file_name)
    %%读取图片
    file = strcat(dir_name, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    image = imread(file);
    [M, N, ~] = size(image);
    img = image(:, end:-1:1, :);
    filename = strcat(image_name, '_lr');
            newName = [filename, ext];
            saveImg = strcat(saveDir, newName);
            imwrite(img, saveImg);
%     for j = 1 : 99 : M-99
%         for k = 1 : 99 :N-99
%             imgPart = image(j:j+99, k:k+99, :);
%             filename = strcat(image_name, '_', num2str(j), '_', num2str(k));
%             newName = [filename, ext];
%             saveImg = strcat(saveDir, newName);
%             imwrite(imgPart, saveImg);
%             
%         end
%     end
    
end