function [imdb] = ELFLoadRawimdb(rawDataDir, descripfilePath)

%%
sinfo = loadjson(descripfilePath);

imdb.class = cellfun(@(x) checkValid(x.class), sinfo(:), 'UniformOutput', false);
imdb.score = cellfun(@(x) checkValid(x.score), sinfo(:), 'UniformOutput', false);
imdb.relativePath = cellfun(@(x) checkValid(x.relpath), sinfo(:), 'UniformOutput', false);
imdb.label = cellfun(@(x) checkValid(x.label), sinfo(:), 'UniformOutput', false);
imdb.rawDataDir = rawDataDir;

imdbPath = fullfile(rawDataDir, 'rawimdb.mat');
save(imdbPath, '-struct', 'imdb');

end
