function iHogFeature(rawPath, featPath)

%%
block_sz = 256;

[~, ~, ext] = fileparts(rawPath);
 
switch olStdExt(ext)
    case '.bmp'
       img = imread(rawPath); 
    case '.avi'
       vidObj = VideoReader(rawPath);
       img = read(vidObj, 1);
end

imgc = olCropCenter(img, block_sz);

cellSize = 8 ;
t = vl_hog(single(imgc), cellSize) ;


%%
for i = 1 : size(t, 3)
    dlmwrite(featPath, t(:,:,i), '-append', 'delimiter', ',');
end

end
