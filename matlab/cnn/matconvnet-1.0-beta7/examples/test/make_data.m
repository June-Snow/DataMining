clc;
clear all;

src = 'D:/STUDY/[1] Í¼Ïñ´¦Àí/resizeÍ¼Æ¬¿â/';
ext = 'bmp'
folders = dir(src);

% i begin with 3 to skip . and ..
ind = 1;
label = 1;
for i = 3 : length(folders)
    files = dir(fullfile([src folders(i).name], ['*.', ext]));

    if isempty(files)
        continue;
    end

    for j = 1 : length(files)
        [pathstr,name,fileext]  = fileparts(files(j).name);
        image_fullpath = [src folders(i).name '/' files(j).name];
        image = rgb2gray(imread(image_fullpath)); 

        data(:, :, 1, ind) = image;
        labels(1, ind) = label;
        ind = ind + 1;
        dst_file_name = [name '.bmp'];
        display([num2str(j), 'dump', dst_file_name,' to mat']);
    end
    label = label + 1;
end

[m n p q] = size(data);
index = randperm(q);

data = data(:,:,:,index);
labels = labels(index);
set = zeros(1,q);
set(1:1500) = 1;
set(1501:end) = 3;
images.data = single(data);
images.labels = labels;
images.set = set;
meta.set = {'train','val','test'};
meta.classes = {0,1,2,3,4,5,6,7,8,9,10,11};
save ('imdb.mat', 'images', 'meta')



