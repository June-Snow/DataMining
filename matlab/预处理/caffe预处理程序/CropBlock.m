%% 把原始图像截成BLOCKWIDTH*BLOCKWIDTH的小块
saveDir = 'C:\Users\Litao\Desktop\test\block\';
dir_name = 'C:\Users\Litao\Desktop\test\';
file_name = dir([dir_name, '*.bmp']);
BLOCKWIDTH = 223;
for i = 1 : length(file_name)
    %%读取图片
    file = strcat(dir_name, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    ext = '.jpg';
    image = imread(file);
    [M, N, ~] = size(image);
    num = 1;
%     for j = 1 : BLOCKWIDTH : M-BLOCKWIDTH
%         for k = 1 : BLOCKWIDTH :N-BLOCKWIDTH
%             %网格取图
%             imgPart = image(j:j+BLOCKWIDTH, k:k+BLOCKWIDTH, :);
%             filename = strcat(image_name, '_', num2str(j), '_', num2str(k));
%             newName = [filename, ext];
%             savePath = strcat(saveDir, image_name, '\');
%             saveImg = strcat(saveDir, newName);
%             num = num + 1;
%             %if(mod(num, 4) == 0)
%                 imwrite(imgPart, saveImg);
%             %end
%             %重叠交叉取图
% %             if((j+BLOCKWIDTH+41) <= M && (k+BLOCKWIDTH+41) <= N )
% %                 imgPart = image(j+41:j+41+BLOCKWIDTH, k+41:k+41+BLOCKWIDTH, :);
% %                 filename = strcat(image_name, '_', num2str(j+41), '_', num2str(k+41));
% %                 newName = [filename, ext];
% %                 savePath = strcat(saveDir, image_name, '\');
% %                 saveImg = strcat(savePath, newName);
% %                 imwrite(imgPart, saveImg);
% %             end
%         end
%     end
    
    for j = 1 : 205 : M-BLOCKWIDTH
        for k = 1 : 183 :N-BLOCKWIDTH
            %网格取图
            imgPart = image(j:j+BLOCKWIDTH, k:k+BLOCKWIDTH, :);
            img(:, :, 1) = imgPart;
            img(:, :, 2) = imgPart;
            img(:, :, 3) = imgPart;
    
            filename = strcat(image_name, '_', num2str(j), '_', num2str(k));
            newName = [filename, ext];
            savePath = strcat(saveDir, image_name, '\');
            saveImg = strcat(saveDir, newName);
            num = num + 1;
            imwrite(img, saveImg);
        end
    end
    %最后一列
    for j = M-BLOCKWIDTH : M-BLOCKWIDTH
        for k = 1 : 183 :N-BLOCKWIDTH
            %网格取图
            imgPart = image(j:j+BLOCKWIDTH, k:k+BLOCKWIDTH, :);
            img(:, :, 1) = imgPart;
            img(:, :, 2) = imgPart;
            img(:, :, 3) = imgPart;
            filename = strcat(image_name, '_', num2str(j), '_', num2str(k));
            newName = [filename, ext];
            savePath = strcat(saveDir, image_name, '\');
            saveImg = strcat(saveDir, newName);
            num = num + 1;
            imwrite(img, saveImg);
        end
    end
    %最后一行
    for j = 1 : 205 : M-BLOCKWIDTH
        for k = N-BLOCKWIDTH :N-BLOCKWIDTH
            %网格取图
            imgPart = image(j:j+BLOCKWIDTH, k:k+BLOCKWIDTH, :);
            img(:, :, 1) = imgPart;
            img(:, :, 2) = imgPart;
            img(:, :, 3) = imgPart;
            filename = strcat(image_name, '_', num2str(j), '_', num2str(k));
            newName = [filename, ext];
            savePath = strcat(saveDir, image_name, '\');
            saveImg = strcat(saveDir, newName);
            num = num + 1;
            imwrite(img, saveImg);
        end
    end
    for j = M-BLOCKWIDTH : M-BLOCKWIDTH
        for k = N-BLOCKWIDTH :N-BLOCKWIDTH
            %网格取图
            imgPart = image(j:j+BLOCKWIDTH, k:k+BLOCKWIDTH, :);
            img(:, :, 1) = imgPart;
            img(:, :, 2) = imgPart;
            img(:, :, 3) = imgPart;
            filename = strcat(image_name, '_', num2str(j), '_', num2str(k));
            newName = [filename, ext];
            savePath = strcat(saveDir, image_name, '\');
            saveImg = strcat(saveDir, newName);
            num = num + 1;
            imwrite(img, saveImg);
        end
    end
end


