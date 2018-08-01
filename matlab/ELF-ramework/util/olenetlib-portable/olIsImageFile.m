function isImage = olIsImageFile(ext)

%%
try
    % Get the list of supported video file formats on this platform
    Extension = getImageExtension;
    % extracting video file extensions
    imageFileExt = Extension;
catch me %#ok<NASGU>
    imageFileExt = {}; % set the extensions list to empty and continue.
end

isImage = any(strcmp(ext, imageFileExt));

end

%%
function imageFormats = getImageExtension()
    imageFormats = {'bmp','jpg', 'jpeg', 'jpeg2000', 'tiff', 'png'};
end