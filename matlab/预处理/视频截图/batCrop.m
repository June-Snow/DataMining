function batCrop(img, filename)
%%
saveDir = 'C:\Users\litao\Desktop\Ñù±¾¼¯';
if ~exist(saveDir)
    mkdir(saveDir);
end
x = input('s');
i = 0;
while(x ~= 0)
    [imcroped rect] = imcrop(img);
    filename = strcat(filename, num2str(i));
    newName = [filename,'.bmp'];
    if ~isempty(imcroped)
        imwrite(imcroped, newName, 'bmp');
        movefile(newName, saveDir,'f');
    end
    x = input('s');
    i = i + 1;
end
end
