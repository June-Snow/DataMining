function [nameNoExt] = olGetNameNoExt(filePath)

%%
[dirStr, nameStr, ext] = fileparts(filePath);
nameNoExt = nameStr;
