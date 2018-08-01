function uv = estimateFlow(im1, im2, varargin)
%UV = ESTIMATE_FLOW_BA(IM1, IM2)   Optical flow computation using Horn & Schunck's method
%   takes in two input images IM1 IM2 (grayscle or color) and compute the
%   flow field from IM1 to IM2 using default parameters. 
%
% output UV is an M*N*2 matrix. UV(:,:,1) is the horizontal flow and
% UV(:,:,2) is the vertical flow.
addpath(genpath('utils'));

% Load flow estimation method
ope = ba_optical_flow;
ope.display = false;

% Parse parameters 
if length(varargin) >=2
    ope = parse_input_parameter(ope, varargin);
end;    

% 2009-3-23 modified by dqsun to deal with input integer images
if isinteger(im1);
    im1 = double(im1);
    im2 = double(im2);
end;

ope.images  = cat(length(size(im1))+1, im1, im2);
uv          = compute_flow(ope, zeros([size(im1,1) size(im1,2) 2]));

end