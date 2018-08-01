
% If you have the Image Processing Toolbox, you can uncomment the following
%   lines to allow input of color images, which will be converted to grayscale.
imageFile = 'E:\github\vs2010\EDTest-VS2010\27.jpg';
image = imread(imageFile);
[~, ~, D] = size(image);
if D == 3
   image = rgb2gray(image);
end

[rows, cols] = size(image);

% Convert into PGM imagefile, readable by "keypoints" executable
f = fopen('E:\github\vs2010\EDTest-VS2010\27.pgm', 'w');
if f == -1
    error('Could not create file tmp.pgm.');
end
fprintf(f, 'P5\n%d %d\n255\n', cols, rows);
fwrite(f, image', 'uint8');
fclose(f);