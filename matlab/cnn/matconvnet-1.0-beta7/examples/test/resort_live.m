clc;
clear all;

src = 'D:/STUDY/[1] 图像处理/STANDARD IMAGE DB/LIVE/';
ext = 'bmp'
mos_mat = 'D:/STUDY/[1] 图像处理/STANDARD IMAGE DB/LIVE/dmos.mat';
mos_info = load(mos_mat);
dmos = mos_info.dmos;
% dmos=[dmos_jpeg2000(1:227) dmos_jpeg(1:233) white_noise(1:174) gaussian_blur(1:174) fast_fading(1:174)] 
dmos_jpeg2000 = dmos(1:227);
dmos_jpeg = dmos(228:460);
white_noise = dmos(461:634);
gaussian_blur = dmos(635:808);
fast_fading = dmos(809:982);

% dmos_cell{:} = {dmos_jpeg2000, dmos_jpeg, white_noise, gaussian_blur, fast_fading };

dmos.info = {} ;
dmos.info{end+1} = struct(...
    'folder_name', 'fastfading',...
    'dmos',fast_fading);

dmos.info{end+1} =  struct(...
    'folder_name', 'gblur',...
    'dmos',gaussian_blur);

dmos.info{end+1} =  struct(...
    'folder_name', 'jp2k',...
    'dmos',dmos_jpeg2000);

dmos.info{end+1} =  struct(...
    'folder_name', 'jpeg',...
    'dmos',dmos_jpeg);

dmos.info{end+1} =  struct(...
    'folder_name', 'wn',...
    'dmos',white_noise);

folders = dir(src);

% i begin with 3 to skip . and ..
ind = 1;
label = 1;
for i = 3 : length(folders)
    if(strcmp('refimgs', folders(i).name))
        continue;
    end
    
    files = dir(fullfile([src folders(i).name], ['*.', ext]));
    
    if isempty(files)
        continue;
    end
    
    for j = 1 : length(dmos.info)
        if strcmp(folders(i).name, dmos.info{j}.folder_name)
            break;
        end
    end
    
    mos = dmos.info{j}.dmos;
    for j = 1 : length(mos)
        score = mos(j);
        filename = ['img' num2str(j) '.bmp'];
        % [pathstr,name,fileext]  = fileparts(files(j).name);
        image_fullpath = [src folders(i).name '/' filename];
        dst_path = [src folders(i).name '/' num2str(ceil(score/10)) '/' ];
       
        if ~exist(dst_path, 'dir')
            mkdir(dst_path);
        end
       
        copyfile(image_fullpath, dst_path);
        display(['dump', filename,' to folder']);
    end
    
end

[m n p q] = size(data);
index = randperm(q);

data = data(:,:,:,index);
labels = labels(index);
set = zeros(1,q);
set(1:800) = 1;
set(801:end) = 3;
images.data = single(data);
images.labels = labels;
images.set = set;
meta.set = {'train','val','test'};
meta.classes = {0,1,2,3,4};
save ('imdb.mat', 'images', 'meta')



