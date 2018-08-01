%%
%Author: 370443976@qq.com (Tao Li)
%function: 把图片转换成灰度图片.
% finish date: 2014/12/5

%%
root = 'F:\GitHub\gitpero\cnn\matconvnet-1.0-beta7\examples\data\live\blocks';
save_file_name = 'block_gray';
image_stype = 'bmp';
str = [];
path_regexp = regexp(root, '\\', 'split');
len = length(path_regexp);
replace_name = path_regexp{len};

path_str = generateFolderTree( root);

for i = 1 : length(path_str)
    path_name = dir(strcat(path_str{i}, '\', '*.', image_stype));
    
    save_path = strrep(path_str{i}, replace_name, save_file_name);
    mkdir_path = strrep(save_path, '\', '/');
    mkdir(mkdir_path);
    
    for j = 1 : length(path_name)
        image_path = strcat(path_str{i}, '\', path_name(j).name);
        ori_img = imread(image_path);
        
        mysize=size(ori_img);
        if numel(mysize)>2
            image = rgb2gray(ori_img);
        end
        
        imwrite(image, strcat(save_path, '\', path_name(j).name));
    end
    
end


    
    
    