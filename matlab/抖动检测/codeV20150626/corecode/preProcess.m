function [Img] = preProcess(Img, M, N)
%%

[row, col, pd] = size(Img);
if pd > 1
    Img = rgb2gray(Img); 
end

if (row ~= M || col~= N)
    Img = imresize(Img, [M N]);
end

end