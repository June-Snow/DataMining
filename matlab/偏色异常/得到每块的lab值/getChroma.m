function re = getChroma(img)
%%  计算色度a、b
%%  计算Lab中a、b的值

re = [];
cform = makecform('srgb2lab');
img_lab = double(applycform(img,cform));% lab空间
l = img_lab(:,:,1); 
a = img_lab(:,:,2); 
b = img_lab(:,:,3); 
l = (l/255)*100;
a=a-128;
b=b-128;
l = reshape(l, [1, 6336]);
a = reshape(a, [1, 6336]);
b = reshape(b, [1, 6336]);
var = [l, a, b];
re(1, 1, :) = var;

end










