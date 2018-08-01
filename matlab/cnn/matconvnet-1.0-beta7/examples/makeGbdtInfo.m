function makeGbdtInfo(folders, images, opts)
if nargin < 1
    load('D:\STUDY\MachineLearning\ML°ü\matconvnet-1.0-beta7\matconvnet-1.0-beta7\examples\data\live-baseline\imdb-live.mat')
    opts.gbdtFile = 'g.txt'
end
imageDir = repmat({imageDir}, [1 length(images.name)]);
images.fullpath = arrayfun(@(x, y) [x{:} filesep y{:}], imageDir, images.name, 'UniformOutput',false);

fid = fopen(opts.gbdtFile, 'w');
arrayfun(@(x, y, z) writePath(fid, x, y, z), images.scores, images.id, images.fullpath);
fclose(fid);


% -------------------------------------------------------------------------
function writePath(fid, score, id, fullpath)
% -------------------------------------------------------------------------
fullpath = strrep(fullpath, '\', '/');
fprintf(fid, [num2str(score) '\t' ...
            num2str(id) '\t' ...
            fullpath{:} '\n']);

