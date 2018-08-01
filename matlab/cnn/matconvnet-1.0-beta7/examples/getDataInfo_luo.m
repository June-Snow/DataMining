<<<<<<< HEAD
% [folders images] = getDataInfo(root, opts);
%
% Parameters illustration :
%   folders is the return value, contains the all folder's infomation which congtains image;
%   images is the return value ,contains the all images infomation which contained in the root;
%   root is the folder path ;
%   opts is the type of the result data ;
%   Signed-off-by: ccolten <lcgwust@163.com> 2014/12/07 ;

function [folders images] = getDataInfo(root, opts)
% root is the path, opts is the choice of the type of the data
=======
function [folders, images] = getDataInfo(root, opts)
% root is the block path, opts is the choice of the type of the data
>>>>>>> 1af32556296f6019871e81b3cac5df1838598635

% TODO : EXPLAIN THE ARGUMENT, ESPECIALLY OPTS. 
%        WHEN ROOT = './live/blocks'; IT WILL FAIL.
% TODO : CHECK WHTHER THE INPUT IS LEGAL OR NOT.
% TODO : TEST

[folders, images] = init();

switch opts.datasetType
    case 'tid', 
        opts.tidDir = 'data/tid/tid2013/';
        [meta] = getTidInfo(opts);
        folders.folder_name = cellfun(@(x) x(1:end-4), meta.names, 'UniformOutput',false);
        folders.folderfullpath = cellfun(@(x) [opts.tidDir 'distorted_images/blocks' filesep x], ...
            folders.folder_name, 'UniformOutput',false);
        folders.folder_id = 1:length(folders.folder_name);
        files = cellfun(@(x) dir(x), folders.folderfullpath, 'UniformOutput',false);
        files = cellfun(@(x) struct2cell(x), files, 'UniformOutput',false);
        files = cellfun(@(x) x(1,3:end), files, 'UniformOutput',false);
        nname = cellfun(@(x) numel(x), files);
        images.names = horzcat(files{:});        
        images.folderid = arrayfun(@(x, y) repmat(x, [1 y]), folders.folder_id, nname, 'UniformOutput', false);
        images.folderid = horzcat(images.folderid{:});
        images.superfolder = arrayfun(@(x, y) repmat(x, [1 y]), folders.folder_name, nname, 'UniformOutput', false);
        images.superfolder = horzcat(images.superfolder{:});
        images.imagesid = 1:length(images.names);
        images.score = arrayfun(@(x, y) repmat(x, [1 y]), meta.score, nname, 'UniformOutput', false);
        images.score = horzcat(images.score{:});
        images.fullpath = cellfun( @(x,y) [opts.tidDir '/distorted_images/blocks/' x '/' y],...
            images.superfolder, images.names, 'UniformOutput', false);
        
    case 'live',
              
    case 'qa',
        [folders, images] = getQaInfo(opts);        
end


%--------------------------------------------------------------------------
function [folders, images] =  init()
%--------------------------------------------------------------------------
folders.folderfullpath = {};
folders.folder_name = {};
folders.folder_id = [];

images.names = {};
images.classes = {};
images.imagesid = [];
images.folderid = [];
images.superfolder = {};
images.fullpath = {};
images.score = [];

<<<<<<< HEAD

folder_count = 1;
image_count = 1;

final_tree = cellfun(@(x) dir(x), final_folderfullpath,'UniformOutput',false);
for j = 1 : length(final_folderfullpath)
    
    %caculate the numbers of the bmp images
    file = ls(strcat(final_folderfullpath{1,j}, '\*.bmp'));
    len = length(file);
    
    % remove the empty folder
    %if the folder contains images , save the folder and images infomation
    if(len >= 1)
        [currentfolder superfolder] = getFolderName(final_folderfullpath{j});
        
        folders(folder_count).folderfullpath = final_folderfullpath{j};
        folders(folder_count).folder_name = currentfolder;
        folders(folder_count).folder_id = j;
        folder_count = folder_count + 1;
      
        for k = 3 : length(final_tree{1,j})
            images(image_count).names = final_tree{1,j}(k).name;
            images(image_count).id = j;
            images(image_count).superfolder = superfolder;
            images(image_count).fullpath = final_folderfullpath{1,j};
            images(image_count).score = k;
            image_count = image_count + 1;
        end
    end
end

end
=======
%--------------------------------------------------------------------------
function [meta] = getTidInfo(opts)
%--------------------------------------------------------------------------
image_path = fullfile(opts.tidDir,'distorted_images', 'blocks');
mosfile_path = fullfile(opts.tidDir, 'mos_with_names.txt');

fileID = fopen(mosfile_path);
C = textscan(fileID,'%f %s');
fclose(fileID);
mos = C{:,1};
filename_list = C{:,2};
>>>>>>> 1af32556296f6019871e81b3cac5df1838598635

l = length(mos);
meta.score = [];
meta.fullpath = cell(1,l);

<<<<<<< HEAD
%--------------------------------------------------------------------------
function [currentfolder superfolder] = getFolderName(currentPath)
% get the father path of the currentPath
    str = currentPath;
    index_dir = strfind(str,'\');
    currentfolder = str(index_dir(end)+1 : end);
    superfolder = str(index_dir(end-1)+1 : index_dir(end)-1);
=======
for i = 1 : length(filename_list)
    image_fullpath = [image_path filesep filename_list{i}];
    meta.score(i) = mos(i);
    meta.fullpath{i} = image_fullpath;
    meta.names{i} = filename_list{i};
>>>>>>> 1af32556296f6019871e81b3cac5df1838598635
end


%--------------------------------------------------------------------------
function [folders, images] = getQaInfo(opts)
%--------------------------------------------------------------------------

images.meta.classes = {'正常视频','DVR冻结','画面冻结','过亮异常','过暗异常','偏色异常',...
    '清晰度异常','抖动异常','信号缺失','雪花噪声','树叶遮挡', '彩色条纹'};
fileID = fopen('./data/qa-baseline/origninfo.txt');
C = textscan(fileID, '%[^\n]')
fclose(fileID);
filename_list = C{:}';

folders.folder_name = arrayfun(@(x) getFoldername(x), filename_list, 'UniformOutput',false);
folders.folderfullpath = arrayfun(@(x) ['./data/qa/blocks/' cell2mat(x{:})], folders.folder_name, 'UniformOutput',false);
folders.folder_id = 1:length(folders.folder_name);
folders.class = cellfun(@(x) getLabel(x, images.meta.classes), folders.folder_name, 'UniformOutput',false);

files = cellfun(@(x) dir(x), folders.folderfullpath, 'UniformOutput',false);
files = cellfun(@(x) struct2cell(x), files, 'UniformOutput',false);
files = cellfun(@(x) x(1,3:end), files, 'UniformOutput',false);

nname = cellfun(@(x) numel(x), files);
images.names = horzcat(files{:}); 
images.folderid = folders.folder_id;
images.superfolder = folders.folder_name;

images.folderid = arrayfun(@(x, y) repmat(x, [1 y]), folders.folder_id, nname, 'UniformOutput', false);
images.classes = arrayfun(@(x, y) repmat(x, [1 y]), folders.class, nname, 'UniformOutput', false);
images.folderid = horzcat(images.folderid{:});
images.superfolder = arrayfun(@(x, y) repmat(x, [1 y]), folders.folder_name, nname, 'UniformOutput', false);
images.superfolder = horzcat(images.superfolder{:});
images.imagesid = 1:length(images.names);
images.fullpath = cellfun( @(x,y) cell2mat([opts.qaDir '/' x '/' y]),...
    images.superfolder, images.names, 'UniformOutput', false);


%--------------------------------------------------------------------------
function folder = getFoldername(path)
%--------------------------------------------------------------------------
strtemp = strsplit(path{:}, {'/', '\'});
folder = {[strtemp{end-1} '/' strtemp{end}(1:end-4) '/']};

%--------------------------------------------------------------------------
function label = getLabel(foldername, classes)
%--------------------------------------------------------------------------

a = cellfun(@(x) strfind(foldername, x),  classes, 'UniformOutput' ,false);
a = cellfun(@(x) cell2mat(x), a,  'UniformOutput' ,false);
a = cellfun(@(x) isempty(x), a);
label = find(a == 0);




