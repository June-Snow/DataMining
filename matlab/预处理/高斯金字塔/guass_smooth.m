%高斯金字塔分成两步:  一对图像做高斯平滑,   二向下采样
%以演示开始.后面是处理过程

%     imbase=imread('C:\Users\Serissa\Desktop\树叶遮挡\1000013634_00001.bmp');
%     imbase=rgb2gray(imbase);
%     imsmooth=Guassion(imbase);
%     im1=DownSample(imsmooth);
%     im1=uint8(im1);
%     imwrite(im1,'128.jpg');
% 
% 
%     imsmooth=Guassion(im1);
%     im1=DownSample(imsmooth);
%     im1=uint8(im1);
%     imwrite(im1,'64.jpg');    
%     
%     imsmooth=Guassion(im1);
%     im1=DownSample(imsmooth);
%     im1=uint8(im1);
%     imwrite(im1,'32.jpg');
%     imsmooth=Guassion(im1);
%     im1=DownSample(imsmooth);
%     im1=uint8(im1);
%     imwrite(im1,'16.jpg');      
%     imsmooth=Guassion(im1);
%     im1=DownSample(imsmooth);
%     im1=uint8(im1);
%     imwrite(im1,'8.jpg');        


    
img1=imread('C:\Users\Serissa\Desktop\树叶遮挡\20_5401.bmp');
[m, n, ~]=size(img1);
w=fspecial('gaussian',[3 3]);
img2=imresize(img1,0.8);
img2 = imfilter(img2,w);
img3=imresize(img1,0.6,'bilinear');
img3=imfilter(img3,w);
img4=imresize(img1,0.4,'bicubic');
img4=imfilter(img4,w);

imshow(img1);
figure,imshow(img2);
figure,imshow(img3);
figure,imshow(img4);


