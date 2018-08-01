function makeDatasetInfo(folders, images, opts)
opts.datasetType = 'live';
path = './data/live/orign/';
folders = dir(path);
folders = folders(3:end);% skip . and ..
files = arrayfun(@(x) dir([path x.name]), folders, 'UniformOutput',false);
leafPath = cell(1, length(folders));
for i = 1 : length(folders)
    leafPath{i} = arrayfun(@(x) [path folders(i).name '/' x.name], files{i}, 'UniformOutput',false);
end
filepaths = vertcat(leafPath{:});

fid = fopen([opts.datasetType, '.txt'], 'w');
arrayfun(@(x, y, z) writePath(fid, x), filepaths);
fclose(fid);

% -------------------------------------------------------------------------
function writePath(fid, fullpath)
% -------------------------------------------------------------------------
if strcmp(fullpath{:}(end), '.') || strcmp(fullpath{:}(end), '..')
    return
end
fullpath = strrep(fullpath, '\', '/');
fprintf(fid, [fullpath{:} '\n']);