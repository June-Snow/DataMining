function out = resample_flow(uv, sz, method)
% function out = resample_flow(uv, factor, method)
%RESAMPLE_FLOW   Resample flow field
%   OUT = RESAMPLE_FLOW(IN, FACTOR[, METHOD]) resamples (resizes) the flow
%   field IN using a factor of FACTOR.  The optional argument METHOD
%   specifies the interpolation method ('bilinear' (default) or
%   'bicubic'). 
%  
%   This is a private member function of the class 'clg_2d_optical_flow'. 


  
  % Make bilinear the default method
  if (nargin < 3)
    method = 'bilinear';
  end
 
  ratio = sz(1) / size(uv,1);
  
  u     = imresize(uv(:,:,1), sz, method)*ratio;
  v     = imresize(uv(:,:,2), sz, method)*ratio;
  out   = cat(3, u, v);
end
  
