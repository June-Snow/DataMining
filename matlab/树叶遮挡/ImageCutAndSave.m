function  ImageCutAndSave(file_path, save_path, image_size, label)

img_path_list = dir(strcat(file_path ,'*.bmp'));
img_num = length(img_path_list);

count = 0;

if img_num > 0
    for i = 1 : img_num
        image_name = img_path_list(i).name;
        save_name = image_name(1:end-4);
        image =  imread(strcat(file_path, image_name));
        count = count + 1;
              
        crop_image = crop_center(image, 32, 32);
        imwrite(crop_image, [save_path, save_name, '_32_32', '.bmp'], 'bmp');
        [M, N, K] = size(crop_image);
            
        Train_x_org(count,:) =  reshape(crop_image, 1, M*N*K);
        Train_y_org(count) = label;   %标签
    end
end

[rows, cols] = size(Train_x_org);
p1 = randperm(rows);
Train_x_org = Train_x_org(p1, 1:cols);
Train_x = Train_x_org(1:round(rows*0.8), :);
Test_x = Train_x_org((round(rows*0.8)+1):rows, :);

Train_y_org = Train_y_org';          %行（1*N）转列（N*1）
Train_y_org = Train_y_org(p1, : );   %行乱序
Train_y = Train_y_org(1: round(rows*0.8), :);
Test_y  = Train_y_org((round(rows*0.8)+1) : rows, :);

save trainMat Train_x Test_x Train_y  Test_y
