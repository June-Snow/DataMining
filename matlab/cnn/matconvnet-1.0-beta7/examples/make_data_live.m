function make_data_live()
%% make data tid2013
% dmos=[dmosjpeg2000(1:227) dmosjpeg(1:233) whitenoise(1:174) gaussianblur(1:174) fastfading(1:174)] 
% where dmosdistortion(i) is the dmos value for image "distortion\imgi.bmp"
% where distortion can be one of the five described above.

% TODO：label也是要的。
opts.format =['cnn', 'gbdt'];
opts.patchnum = 200;
opts.patchsz = [32 32];
opts.trainpartion = 0.6;
opts.imdbPath = '.\data\live-baseline\imdb-3232rgb-live-scorechange.mat';
opts.liveDir = 'D:\STUDY\[1] 图像处理\STANDARD IMAGE DB\live\';
opts.imageDir = opts.liveDir;
opts.imagemode = 'gray';
opts.blockextrainfo = [];

liveData = getLiveData(opts.liveDir);
imdb = initImdb();
imdb.imageDir='./data/live/blocks'

h=waitbar(0,'待って，計算する');
fid = fopen('gbdt.txt', 'w');
id = 1;
for i = 1 : length(liveData)
    folderfullpath = liveData(i).fullpath;
    foldername = liveData(i).folder;
    local_names = liveData(i).local_name;
    mos = liveData(i).mos;       
    opts.blocks_dir = [opts.imageDir filesep 'blocks' filesep foldername];    
    imdb_temp = cell([1 length(local_names)]);
    
    for j = 1 : length(local_names) 
        [blocks meta] = proc_blocks([folderfullpath  filesep local_names{j}], mos(j), opts, id);
        imdb_temp{j} = meta;
        imdb_temp{j}.name = arrayfun(@(x) [foldername filesep x{:}], imdb_temp{j}.name,'UniformOutput', false);

        fprintf('processing folder %s file %s.\n', foldername, local_names{j});
        waitbar(j/length(local_names),h,'待って');
        id = id + 1;
    end
    
    for k = 1 : length(imdb_temp)
        imdb.images.name = horzcat(imdb.images.name, imdb_temp{k}.name);
        imdb.images.scores =  horzcat(imdb.images.scores, imdb_temp{k}.score);
        imdb.images.id = horzcat(imdb.images.id, imdb_temp{k}.id);
    end

    clear imdb_temp
end
fclose(fid);

% ↓下面的代码没有检查过，运行的时候注意
l = length(imdb.images.name);
imdb.images.set = zeros([1,length(imdb.images.name)]);
ind = randperm(l);
imdb.images.name = imdb.images.name(ind);
imdb.images.scores = imdb.images.scores(ind);
imdb.images.id = imdb.images.id(ind);

imdb.images.set(1:ceil(0.6*l)) = 1;
imdb.images.set(ceil(0.6*l)+1:ceil(0.6*l+0.4*0.5*l)) = 2;
imdb.images.set(ceil(0.6*l+0.4*0.5*l)+1:end) = 3;

score = (images.scores/100);
imdb.images.label = ceil(score*10);

waitbar(1,h,'完成した');

[phstr ~] = fileparts(opts.imdbPath);
if ~exist(phstr, 'dir')
    opts.imdbPath = '.';
end
% save(opts.imdbPath, '-struct', 'imdb'); 


%--------------------------------------------------------------------------
function [blocks meta] = proc_blocks(imgPath, score, opts, id)
%--------------------------------------------------------------------------
[pathstr, name, ext] = fileparts(imgPath);
img = imread(imgPath);
block_dir = opts.blocks_dir;
if isempty(opts.blocks_dir)
    block_dir = [pathstr filesep 'blocks'];
end

blocks = im2block(img, opts.patchsz, opts.patchsz(1));

if ~exist(block_dir)
    mkdir(block_dir);
end
meta = save_blocks(blocks, [block_dir filesep], name, ext);
num = numel(meta.name);
meta.score = repmat(score, [1, num]);
meta.classes = repmat(single(ceil(score*10)), [1, num]);% tid's mos is [0 9]
meta.id = repmat(id, [1 num]);


%--------------------------------------------------------------------------
function  get_gbdt_format(fid, block, score, opts)
%--------------------------------------------------------------------------
img = block;
if strcmp(opts.imagemode, 'gray')
    img = rgb2gray(img);
end
line = procData4ML(img, score, 'type', 'whole');
fprintf(fid, line);

%--------------------------------------------------------------------------
function [meta] = get_cnn_format(imgPath, score, opts, id)
%--------------------------------------------------------------------------
[pathstr, name, ext] = fileparts(imgPath);
img = imread(imgPath);
block_dir = opts.blocks_dir;
if isempty(opts.blocks_dir)
    block_dir = [pathstr filesep 'blocks'];
end

num = numel(meta.name);
meta.score = repmat(score, [1, num]);
meta.classes = repmat(single(ceil(score*10)), [1, num]);% tid's mos is [0 9]
meta.id = repmat(id, [1 num]);

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
    %imwrite(blocks(:,:,:,i), [subfolder_path filename '-' num2str(i) ext]);
    meta.name(end+1) = { [filename filesep block_name] };
end


%--------------------------------------------------------------------------
function [liveData] = getLiveData(liveDir)
%--------------------------------------------------------------------------
folderpaths = generateFolderTree(liveDir, 2, ['refimgs' 'blocks' 'Live分级']);
load(fullfile(liveDir, 'dmos.mat'));
mosind = {[1:227],[228:460],[461:634],[635:808],[809:982]};
mosrank = {'jp2k','jpeg','wn','gblur','fastfading'};
% dmosjpeg2000(1:227) dmosjpeg(1:233) whitenoise(1:174) gaussianblur(1:174) fastfading(1:174)


for i = 1 : length(folderpaths)
    ret = strsplit(folderpaths{i}, {'\','/'});
    folder_name = repmat(ret(end), [1 5]);
    ind = arrayfun(@(x, y)strcmp(x, y), folder_name, mosrank);
    
    liveData(i).mos = dmos(mosind{find(ind==1)});
    namenum = [1:length(liveData(i).mos)];
    liveData(i).local_name = arrayfun(@(x) ['img', num2str(x), '.bmp'], ...
        namenum, 'UniformOutput', false);
    liveData(i).folder = ret{end};
    liveData(i).fullpath = folderpaths{i};
end


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
