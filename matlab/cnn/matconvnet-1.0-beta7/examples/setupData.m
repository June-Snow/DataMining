function [metaPath, imdbPath] = setupData(opts)
% ROOT 到blocks层
% 此函数值针对块库
datasetType = 'qa';
opts = initOpts(datasetType);
root = './data/qa/blocks';

if ~exist(opts.infoDir, 'file')
    [folders, images] = getDataInfo(root, opts);
    meta.images = images;
    meta.folders = folders;
    save(opts.infoDir, '-struct', 'meta');
end
load(opts.infoDir);

if ~exist(opts.imdbDir, 'file')
    imdb = makeCnnData(images, folders, opts);
    save(imdbPath, '-struct', 'imdb');
end
metaPath = opts.infoDir;
imdbPath = opts.imdbDir;

%--------------------------------------------------------------------------
function opts = initOpts(datasetType)
%--------------------------------------------------------------------------
switch datasetType
    case 'tid',
        opts.datasetType = 'tid';
        opts.blocksDir = root;
        opts.infoDir = ['./data/tid-baseline/' opts.datasetType 'meta.mat'];
        opts.imdbDir = './data/tid-baseline/imdb.mat';
    case 'live',
    case 'qa',
        opts.datasetType = 'qa';
        opts.blocksDir = root;
        opts.qaDir = 'data/qa/blocks';
        opts.infoDir = ['./data/qa/' opts.datasetType 'meta.mat'];
        opts.imdbDir = './data/qa/imdb.mat';
end