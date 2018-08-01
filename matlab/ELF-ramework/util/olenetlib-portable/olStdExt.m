function ext = olStdExt(ext)

%%
if iscell(ext)
    ext = cell2mat(ext);
end
dotind = strfind(ext, '.');
if isempty(dotind)
    ext = ['.', ext];
end