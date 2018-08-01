%不支持文件中有注释
% pgm_image_name='E:\github\vs2010\EDTest-VS2010\CannySR-EdgeMap.pgm';
% f = fopen(pgm_image_name,'r');
% if f == -1
%     error(['Could not open file ',pgm_image_name]);
% end
% [imgsize, num]=fscanf(f, 'P5\n%d %d\n255\n');
% if num~=2,error('error num');end
% image=[];
% for h=1:imgsize(2)
%     image=[image fread(f,imgsize(1),'uint8')];
% end
% image=image.';
% fclose(f);
% imshow(image);
pgm_image_name='E:\github\vs2010\EDTest-VS2010\ED-EdgeMap.pgm';
path = 'C:\Users\LiTao\Desktop\实验对比图\EDPFstreet.jpg';
img = imread(pgm_image_name);
imwrite(img, path);




