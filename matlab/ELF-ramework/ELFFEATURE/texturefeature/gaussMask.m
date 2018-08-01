function gmask = gaussMask(w, sigma)
 
ww = 2*w + 1;
 
[x,y] = meshgrid(-w:w, -w:w);
 
gmask = 1/(2*pi) * exp( -(x.^2 + y.^2)/2/sigma^2);
gmask = gmask / sum(sum(gmask));
