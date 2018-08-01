function isVideo = olIsVideoFile(ext)

%%
try
    % Get the list of supported video file formats on this platform
    videoFileFormats = VideoReader.getFileFormats;
    % extracting video file extensions
    videoFileExt = {videoFileFormats.Extension};
catch me %#ok<NASGU>
    videoFileExt = {}; % set the extensions list to empty and continue.
end

isVideo = any(strcmp(ext, videoFileExt));

end