function [imdb] = makeCnnData(images, folders, opts)

imdb = initImdb();
opts.setpartion = [0.6, 0.2, 0.2];
opts.patchsz = [32 32]

switch opts.datasetType
    case 'tid',
        makeTidData(imdb, images, folders, opts)
    case 'live',
        
    case 'qa',
        getQaImdb(imdb, images, folders, opts)
end

% -------------------------------------------------------------------------
function makeTidData(imdb, images, folders, opts)
% -------------------------------------------------------------------------
names = {};scores = {}; classes = {};
if 1
    names = images.fullpath;
    scores = images.score;
    label = ceil(images.score*10);
else % origin image
    for i = 1 : numel(folders.folderfullpath)
        imdb_temp = get_cnn_format(images.fullpath{i}, images.score(i), opts);
        names{end+1} = imdb_temp.name;
        scores{end+1} = imdb_temp.score;
        classes{end+1} = imdb_temp.classes; 
        names = horzcat(names{:}) ;
        scores= horzcat(scores{:}) ;
        classes = horzcat(classes{:}) ;
        %     display(['num,s length :¡¡' num2str(numel(names))]);
        %     disp_progress(i, numel(image_fullpaths));
        %     display(['finished procsess ' image_fullpaths{i}]);
    end
    
end

n = numel(names);
ind = randperm(n);
imdb.images.name = names(ind);
imdb.images.scores = scores(ind);
imdb.images.label = label(ind);
imdb.images.classes = classes(ind);
imdb.images.set(1:ceil(n*opts.trainpartion(1))) = 1;
imdb.images.set(ceil(n*opts.trainpartion(1))+1:ceil(n*opts.trainpartion(1))+1+ceil(n*opts.trainpartion(2))) = 2;
imdb.images.set(ceil(n*opts.trainpartion(1))+1+ceil(n*opts.trainpartion(2))+1:end) = 3;
imdb.imageDir = opts.blocks_dir;

[phstr ~] = fileparts(opts.imdbPath);
if ~exist(phstr, 'dir')
    opts.imdbPath = '.';
end
save(opts.imdbPath, '-struct', 'imdb');


%--------------------------------------------------------------------------
function [meta] = get_cnn_format(imgPath, score, opts)
%--------------------------------------------------------------------------
[pathstr, name, ext] = fileparts(imgPath);
img = imread(imgPath);
blocks = im2block(img, opts.patchsz, opts.patchsz(1));
meta = makeBlockInfo(blocks);
num = numel(meta.name);
meta.score = repmat(score, [1, num]);
meta.classes = repmat(single(ceil(score*10)), [1, num]);% tid's mos is [0 9]


if isempty(opts.blocks_dir)    
    block_dir = [pathstr filesep 'blocks'];
end
block_dir = opts.blocks_dir
if ~exist(block_dir)
    mkdir(block_dir);
    save_blocks(blocks, [block_dir filesep], meta);
end

%--------------------------------------------------------------------------
function  [meta] =  getQaImdb(imdb, images, folders, opts)
%--------------------------------------------------------------------------
names = images.fullpath;
label = images.classes;
n = numel(names);
ind = randperm(n);
imdb.images.name = names(ind);
imdb.images.label = label(ind);
imdb.images.classes = label(ind);
imdb.images.set(1:ceil(n*opts.setpartion(1))) = 1;
imdb.images.set(ceil(n*opts.setpartion(1))+1:ceil(n*opts.setpartion(1))+1+ceil(n*opts.setpartion(2))) = 2;
imdb.images.set(ceil(n*opts.setpartion(1))+1+ceil(n*opts.setpartion(2))+1:end) = 3;
imdb.imageDir = opts.blocks_dir;

[phstr ~] = fileparts(opts.imdbDir);
if ~exist(phstr, 'dir')
    opts.imdbDir = '.';
end
save(opts.imdbDir, '-struct', 'imdb');




%--------------------------------------------------------------------------
function [meta] = makeBlockInfo(blocks, filename, ext)
%--------------------------------------------------------------------------
n = size(blocks, 4);
meta.name = {};

for i = 1 : n
    block_name = [filename '-' num2str(i) ext];    
    meta.name(end+1) = { [filename filesep block_name] };
end

%--------------------------------------------------------------------------
function [meta] = save_blocks(blocks, path, meta)
%--------------------------------------------------------------------------
n = size(blocks, 4);

for i = 1 : n
    subfolder_path =[ path filesep meta(i).filename filesep];
    if ~exist(subfolder_path, 'dir')
        mkdir(subfolder_path)
    end
    imwrite(blocks(:,:,:,i), [subfolder_path meta(i).filename]);
end



% -------------------------------------------------------------------------
function [imdb] = initImdb()
% -------------------------------------------------------------------------
imdb.images.name = {};
imdb.images.score = [];
imdb.images.label = [];
imdb.images.classes = [];
imdb.images.set = [];
imdb.images.id = [];