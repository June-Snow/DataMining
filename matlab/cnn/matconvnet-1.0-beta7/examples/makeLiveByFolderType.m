function makeLiveByFolder()

if nargin < 1
    imdb = load('.\data\live-baseline\imdb-live-right.mat');
    opts.gbdtFile = 'g.txt';
    opts.imdbPath = '.\data\live-baseline\imdb-typebyfolder2.mat';
end

liveFolders = {{'jp2k','jpeg','wn','gblur','fastfading'}};
liveFolders = repmat(liveFolders, [1 length(imdb.images.name)]);
ind = arrayfun(@(x, y) findname(x, y), imdb.images.name, liveFolders);
imdb.images.label = ind;
save(opts.imdbPath, '-struct', 'imdb');      


function ind = findname(name, pattern)
name = repmat(name, [1, length(pattern{:})]);
p(1).patter = pattern{1}{1};
p(2).patter = pattern{1}{2};
p(3).patter = pattern{1}{3};
p(4).patter = pattern{1}{4};
p(5).patter = pattern{1}{5};
ind = arrayfun(@(x, y) strfind(x, y.patter), name, p,'UniformOutput', false);
index = zeros([1, length(ind)]);
ind = cellfun(@(x) ~isempty(cell2mat(x)), ind);
ind = find(ind==1);
