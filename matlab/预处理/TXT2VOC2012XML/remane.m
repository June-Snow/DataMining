%假设图片放置于"images\"下，需要将其规范命名到"image-convert\"下
imgs = dir(['images\','*.jpg']);
for i = 1:length(imgs)
    imgPath = ['images\',imgs(i).name];
    img = imread(imgPath);
    imgPathTrans = ['image-convert\',num2str(i,'%06d'),'.jpg'];
    imwrite(img,imgPathTrans);
end