clear all
close all
clc

imageFile = 'E:\github\vs2010\EDTest-VS2010\27.jpg';
image = imread(imageFile);
figure;imshow(image);

imageFile = 'E:\github\vs2010\EDTest-VS2010\CannySR-EdgeMap.pgm';
image = imread(imageFile);
figure;imshow(image);

imageFile = 'E:\github\vs2010\EDTest-VS2010\CannySRPF-EdgeMap.pgm';
image = imread(imageFile);
figure;imshow(image);

imageFile = 'E:\github\vs2010\EDTest-VS2010\27.jpg';
image = imread(imageFile);
image = rgb2gray(image);
image = edge(image, 'canny');
figure;imshow(image);