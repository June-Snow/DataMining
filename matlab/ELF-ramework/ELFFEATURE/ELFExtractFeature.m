function [featImdb, image] = ELFExtractFeature(featName, pathes, dim, mode)%, stdInfo, sep)

%%
global DEBUG;
showWaitBar = 0;

if ~exist('mode', 'var')
    mode = 'test';
end

if strcmp('train', mode) == 1
    showWaitBar = 1;
end

featImdb = iInitFeatImdb();
% featImdb.featDataDir = tempDir;


%%
if showWaitBar, h = waitbar(0,'Extracting Feature...'); end;
for i = 1 : length(1)%pathes)
    rawPath = pathes;%{i};
    
    switch dim
        case 1, featImdb.feature{i} = iExtract1DFeature(featName, rawPath, mode);                
        case 2, [featImdb.feature{i}] = iExtract2DFeature(featName, rawPath, mode);
    end
    
    if showWaitBar, waitbar(i / length(pathes)), end;
end
if showWaitBar, close(h), end;
% if DEBUG, close(905); end