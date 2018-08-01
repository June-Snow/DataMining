function output = olCropCenter(I, SZ)

%%
if ndims(I) > 2
    output(:,:,1) = olCropCenter(I(:,:,1), SZ);
    output(:,:,2) = olCropCenter(I(:,:,2), SZ);
    output(:,:,3) = olCropCenter(I(:,:,3), SZ);
else
    [M, N, ~] = size(I);
    scale_ratio = SZ / min(M, N) ;
    I_ = imresize(I, scale_ratio);
    [M_, N_, ~] = size(I_);
    center_m = ceil(M_/2);
    center_n = ceil(N_/2);
    output = I_( max(center_m - floor(SZ/2), 1) : min(center_m+floor(SZ/2), M), ...
        max(center_n-SZ/2,1) : min(center_n+floor(SZ/2), N));
    output = imresize(output, [SZ SZ]);
end
