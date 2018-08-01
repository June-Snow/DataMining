function [It, Ix, Iy] = partial_deriv(images, uv_prev, interpolation_method, deriv_filter)
%PARTIAL_DERIV   Spatio-temporal derivatives
%   P = PARTIAL_DERIV computes the spatio-temporal derivatives
%   P between IMAGES using the flow field UV_PREV with specified
%   INTERPOLATION_METHOD ('bi-linear' or 'bi-cubic') and derivative filters
%
if nargin == 2
    interpolation_method = 'bi-linear';
end;

H   = size(images, 1);
W   = size(images, 2);

[x,y]   = meshgrid(1:W,1:H);
x2      = x + uv_prev(:,:,1);
y2      = y + uv_prev(:,:,2);

if strcmp(interpolation_method, 'bi-cubic')
    
    if size(images, 4) == 1
        % gray-level
        [warpIm Ix Iy] = interp2_bicubic(images(:,:,2),x2,y2);
    else
        % color
        warpIm  = zeros(size(images(:,:,:,1)));
        Ix      = warpIm;
        Iy      = warpIm;
        for j = 1:size(images,3)
            [warpIm(:,:,j) Ix(:,:,j) Iy(:,:,j)] = interp2_bicubic(images(:,:,j,2),x2,y2);
        end;
    end;
    
    indx        = isnan(warpIm);
    if size(images, 4) == 1
        It          = warpIm - images(:,:,1);
    else
        It          = warpIm - images(:,:,:,1);
    end;
    
    % Disable those out-of-boundary pixels in warping
    It(indx)    = 0;
    if nargout == 3
        Ix(indx) = 0;
        Iy(indx) = 0;
    end;
    
elseif strcmp(interpolation_method, 'bi-linear')
    
    % Linear interpolation is more robust though gradient is approximately
    % computed
    if size(images, 4) == 1
        % gray-level
        warpIm  = interp2(x,y,images(:,:,2),x2,y2,'linear', NaN);
        tmp     = images(:,:,1);
    else
        % color
        warpIm  = zeros(size(images(:,:,:,1)));
        for j = 1:size(images,3)
            warpIm(:,:,j) = interp2(x,y,images(:,:,j,2),x2,y2,'linear', NaN);
            tmp           = images(:,:,:,1);
        end;
    end;
    
    % Disable those out-of-boundary pixels in warping
    B         = isnan(warpIm);
    warpIm(B) = tmp(B);
    It        = warpIm - tmp;
    
    if nargin == 4
        h = deriv_filter;
    else
        h = [-1 9 -45 0 45 -9 1]/60;        % derivative used by Bruhn et al "combing "IJCV05' page218
    end;
    
    if nargout == 3
        Ix        = imfilter(warpIm, h,  'corr', 'symmetric', 'same');  %
        Iy        = imfilter(warpIm, h', 'corr', 'symmetric', 'same');
    end;
else
    error('partial_deriv: unknown interpolation method!');
end;