function [ relpath ] = olCvt2Relpath(root, fullpath )

%%
relpath = strrep(fullpath, root, '');
end

