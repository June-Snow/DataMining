function [ output ] = olCropTopBot( input, crop_top, crop_bot )

%%
[M, N, ~] = size(input);
ymin_up = floor(M * crop_top);
ymin_down = floor(M * crop_bot);
xmin = 0;
rect_H = M - ymin_up - ymin_down;
rect_W = N;
rect = [xmin ymin_up rect_W rect_H];
output = imcrop(input, rect);

end

