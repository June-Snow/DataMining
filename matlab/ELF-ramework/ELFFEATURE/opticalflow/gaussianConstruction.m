function h = gaussianConstruction(sigma)

%%
size = fix(6*sigma)/2;
if ~mod(size,2);
    size = size+1;
end

h = fspecial('gaussian', size, sigma);

end