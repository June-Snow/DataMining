function cropCenter(save_path,dir_name, M, N)
%%
file_list = getAllFiles( dir_name);
if isempty(file_list);
    error('设定的文件夹内没有任何的图片，请重新检查...')
end

for i = 1 : length(file_list)
    img_path = file_list{i};
    image = imread(img_path);   
    [pathstr, name, ext] = fileparts(img_path);   
    [rows ,cols , channels] = size(image);
    center_x = round(rows/2);
    center_y = round(cols/2);
    cut_x = round(M/2);
    cut_y = round(N/2);
    crop_image = image(center_x-cut_x : center_x+cut_x-1, center_y-cut_y : center_y+cut_y-1 , : );
    
    imwrite(crop_image, strcat( save_path, '\', name, ext));
end
end


