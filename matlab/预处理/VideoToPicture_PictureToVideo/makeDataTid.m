function makeDataTid()
%% make data tid2013
opts.format = 'cnn';
opts.patchnum = 200;
opts.patchsz = [28 28];
opts.trainpartion = 0.6;
opts.imdbPath = '.\tid-baseline\imdb.mat';

tidData = getTidData();
mos = tidData.mos;
image_fullpaths = tidData.image_fullpath;

images.datadir = {};
images.labels = [];

if strcmp(opts.format, 'gbdt')
    fid = fopen('gbdt.txt', 'w');
    for i = 1 : length(image_fullpaths)
        imgPath = image_fullpaths{i};
        score = mos(i);
        str_temp = strsplit(imgPath, {'\','/'});
        filename = str_temp{end};
    
        get_gbdt_format(fid, imgPath, score);
        display('lbalbalbal');
    end
    fclose(fid);
end

if strcmp(opts.format, 'cnn' )
    if 0 % path mode
        images.datadir = tidData.image_fullpaths;
        images.labels = tidData.mos;
        imdb.images.name;
        
        %[m n p q] = size(images.data);
        %index = randperm(q);
        
        num =  numel(images.datadir);
        set = zeros(1, num);
        set(1:floor(num*opts.trainpartion)) = 1;
        set(floor(num*opts.trainpartion)+1:end) = 3;
        %images.data = images.data(:,:,:,index);
        %images.labels = images.labels(1, index);
        images.set = set;
        meta.set = {'train','val','test'};
        meta.classes = {0,1,2,3,4,5,6,7,8,9,10,11};
        save ('./data/tid-baseline/imdb.mat', 'images', 'meta')
    end
    
    if 1 % image mode (memory is alwayes not enough)
        meta = struct();
        names = {};scores = {}; classes = {};
        
        for i = 1 : numel(image_fullpaths)
            meta_temp = get_cnn_format(image_fullpaths{i}, mos(i), opts);
            names{end+1} = meta_temp.name;
            scores{end+1} = meta_temp.score;
            classes{end+1} = meta_temp.classes;
            %fprintf('.') ;
            %if mod(i, 50) == 0, fprintf('\n') ; end  
            disp_progress(i, numel(image_fullpaths));
            display(['finished procsess ' image_fullpaths{i}]);
            
        end
   
        names = horzcat(names{:}) ;
        scores= horzcat(scores{:}) ;
        classes = horzcat(classes{:}) ;
        
        meta.name = names;
        meta.score = scores;
        meta.classes = classes;
             
        save(opts.imdbPath, 'meta');
    end
end


%--------------------------------------------------------------------------
function get_gbdt_format(fid, imgPath, score)
%--------------------------------------------------------------------------
img = imread(imgPath);
line = procData4ML(img, score);
 fprintf(fid, line);

%--------------------------------------------------------------------------
function [meta] = get_cnn_format(imgPath, score, opts)
%--------------------------------------------------------------------------
[pathstr, name, ext] = fileparts(imgPath);
img = imread(imgPath);
blocks = im2block(img, opts.patchsz, opts.patchsz(1));
block_dir = [pathstr filesep 'blocks'];
if ~exist(block_dir)
    mkdir(block_dir);
end
meta = save_blocks(blocks, name, ext, block_dir);
num = numel(meta.name);
meta.score = repmat(score, [1, num]);
meta.classes = repmat(single(ceil(score)), [1, num]);% tid's mos is [0 9]

%--------------------------------------------------------------------------
function [meta] = save_blocks(blocks, filename, ext, dst)
%--------------------------------------------------------------------------
n = size(blocks, 4);
meta.name = {};

for i = 1 : n
    block_name = [filename '-' num2str(i) ext];    
    imwrite(blocks(:,:,:,i), [dst filesep block_name]);
    meta.name(end+1) = {block_name};
end