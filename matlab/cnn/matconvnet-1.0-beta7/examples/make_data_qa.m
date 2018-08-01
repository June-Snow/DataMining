function make_data_qa()

opts.patchsz = [32 32];
opts.imdbPath = './data/live-baseline/imdb-qa.mat';
opts.qaDir = 'D:/STUDY/MachineLearning/ML°ü/matconvnet-1.0-beta7/matconvnet-1.0-beta7/examples/data/qa/ÊÓÆµ¿â4.1/';
opts.imageDir = opts.qaDir;
opts.imagemode = 'gray';
opts.blockextrainfo = [];
opts.datasetType = 'qa';
opts.blocks_dir = 'data/qa/blocks';

[folders, images] = getQaData(opts);
imdb = initImdb();
imdb.imageDir='./data/qa/blocks'

for i = 2 : length(folders.folderfullpath)
    fprintf('processing folder %s file.\n', folders.folderfullpath{i});
    % j start from 3 to skip . and ..
    files = dir(folders.folderfullpath{i});
    for j = 3 : length(files)
        image_name = files(j).name;
        proc_blocks([folders.folderfullpath{i} '/'  image_name], opts); 
    end
end
fprintf('Done.\n');

%--------------------------------------------------------------------------
function [blocks meta] = proc_blocks(imgPath, opts)
%--------------------------------------------------------------------------
[pathstr, name, ext] = fileparts(imgPath);
temp = strsplit(pathstr, '\');
superfolder = temp(end);
img = imread(imgPath);
block_dir = opts.blocks_dir;
if isempty(opts.blocks_dir)
    block_dir = [pathstr filesep 'blocks'];
end

blocks = im2block(img, opts.patchsz, opts.patchsz(1));

if ~exist(block_dir)
    mkdir(block_dir);
end
meta = save_blocks(blocks, [block_dir filesep superfolder{:}], name, ext);


%--------------------------------------------------------------------------
function [meta] = save_blocks(blocks, path, filename, ext)
%--------------------------------------------------------------------------
n = size(blocks, 4);
meta.name = {};
subfolder_path =[ path filesep filename filesep];

for i = 1 : n
    if ~exist(subfolder_path, 'dir')
        mkdir(subfolder_path)
    end
    block_name = [filename '-' num2str(i) ext];
    imwrite(blocks(:,:,:,i), [subfolder_path filename '-' num2str(i) ext]);
    meta.name(end+1) = { [filename filesep block_name] };
end


%--------------------------------------------------------------------------
function [folders, images]  = getQaData(opts)
%--------------------------------------------------------------------------
folders.folderfullpath = generateFolderTree(opts.qaDir);
images.names = cellfun(@(x) dir(x), folders.folderfullpath, 'UniformOutput',false);


%--------------------------------------------------------------------------
function imdb = initImdb()
%--------------------------------------------------------------------------
imdb.images.name = {};
imdb.images.scores = [];
imdb.images.label = [];
imdb.images.classes = [];
imdb.images.set=[];
imdb.images.id = [];
imdb.imageDir = [];