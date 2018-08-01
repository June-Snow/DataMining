function pathNoExt = olGetPathNoExt(filename)

%%
[dirStr, nameStr, ext] = fileparts(filename);
pathNoExt = fullfile(dirStr, nameStr);

end