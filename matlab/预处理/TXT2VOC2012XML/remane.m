%����ͼƬ������"images\"�£���Ҫ����淶������"image-convert\"��
imgs = dir(['images\','*.jpg']);
for i = 1:length(imgs)
    imgPath = ['images\',imgs(i).name];
    img = imread(imgPath);
    imgPathTrans = ['image-convert\',num2str(i,'%06d'),'.jpg'];
    imwrite(img,imgPathTrans);
end