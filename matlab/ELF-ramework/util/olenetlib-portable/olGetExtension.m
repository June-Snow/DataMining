function [ext, description] = olGetExtension(filename)
%  try to get imfinfo (if file is image, use "im")

%%

[~,~,ext]=fileparts(filename);
description = '';

return;