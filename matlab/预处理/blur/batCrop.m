function batCrop(img, filename)
%%
[imcroped rect] = imcrop(img);
% imcroped = img;
newName = [filename,'.bmp'];
if ~isempty(imcroped)
    imwrite(imcroped, newName, 'bmp');
    newDir = 'blur';
    if ~exist(newDir)
        mkdir(newDir);
    end
    movefile(newName, newDir,'f');
end
end