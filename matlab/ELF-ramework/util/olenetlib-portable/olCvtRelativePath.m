function [relaPath] = olCvtRelativePath(root, path)

%%
if ~exist(root, 'dir')
    relaPath = -1;
    disp('path not exists');
    return;
end

if strcmp(root(1), '.')
    relaPath = root(2:end);
else
    relaPath = path;
    [ind] = strfind(path, root);
    assert(ind == 1, 'number of parameter path should be 1');
    relaPath(ind : ind + length(root)-1) = [];    
end