function [isVideo] = olIsVideoPath(filePath)

%%
[dirStr, fileName, ext] = fileparts(filePath);
isVideo = 0;
 
 if strcmp(olStdExt(ext), '.avi')
    isVideo = 1;
 end

end