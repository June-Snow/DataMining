function rgbToGray(root, image_type)
%%
% root = 'F:\ÊÓÆµ²âÊÔ\Í¼Æ¬²Ã¼ô\';
path_str = generateFolderTree( root);
% str = [];
for i = 1 : length(path_str)
    path_name = dir(strcat(path_str{i}, '\', '*.',image_type));
    for j = 1 : length(path_name)
        image_path = strcat(path_str{i}, '\', path_name(j).name);
        ori_img = imread(image_path);
        
        %imshow(oriImg);
        %         path_str_split = regexp(path_str{i}, '\:', 'split');%´´½¨´æ´¢Â·¾¶
        %         path_str_name = strcat(disk_path, path_str_split{2});
        %         path_str_mkdir = strrep(path_str_name, '\', '/');
        %
        %         if~(strcmp(str, path_str{i}))
        %             mkdir(path_str_mkdir);
        %             str = path_str{i};
        %         end
        mysize=size(ori_img);
        if numel(mysize)>2
            
            image = rgb2gray(ori_img);
        end
        %         imwrite(image, strcat(path_str_name, '\', path_name(j).name));
        imwrite(image, image_path);
    end
end
end

    
    
    