function Y = vl_nnsoftmaxloss(X,c,dzdy)
% VL_NNSOFTMAXLOSS  CNN combined softmax and logistic loss
%  Y = VL_NNSOFTMAX(X, C) applies the softmax operator followed by
%  the logistic loss the data X. X has dimension H x W x D x N,
%  packing N arrays of W x H D-dimensional vectors.
%
%  C contains the class labels, which should be integer in the range
%  1 to D.  C can be an array with either N elements or with H x W x
%  1 x N dimensions. In the fist case, a given class label is
%  applied at all spatial locations; in the second case, different
%  class labels can be specified for different locations.
%
%  D can be thought of as the number of possible classes and the
%  function computes the softmax along the D dimension. Often W=H=1,
%  but this is not a requirement, as the operator is applied
%  convolutionally at all spatial locations.
%
%  DZDX = VL_NNSOFTMAXLOSS(X, C, DZDY) computes the derivative DZDX
%  of the CNN with respect to the input X given the derivative DZDY
%  with respect to the block output Y. DZDX has the same dimension
%  as X.

% Copyright (C) 2014 Andrea Vedaldi.
% All rights reserved.
%
% This file is part of the VLFeat library and is made available under
% the terms of the BSD license (see the COPYING file).

%X = X + 1e-6 ;

% e.g.:
% 假设X为[1 1 5 10], 则Xmax为[1 1 1 10]
% c  = [5  1  4  6  9  7  10  3  2  8]'
% later c = [4  0  3  5  8  6  9  2  1  7]'
% later c becomes 4-D array, the 4th dimention is the label
% like c(1,1,1,:) is equal to the before c 
% c_ = 0  1  2  3  4  5  6  7  8  9
% c_ = 5   6  14  21  29  32  40  38  42  53

sz = [size(X,1) size(X,2) size(X,3) size(X,4)] ;

% index from 0
c = c - 1 ;

if numel(c) == sz(4)
  % one label per image
  c = reshape(c, [1 1 1 sz(4)]) ;
  c = repmat(c, [sz(1) sz(2)]) ;
else
  % one label per spatial location
  sz_ = size(c) ;
  assert(isequal(sz_, [sz(1) sz(2) 1 sz(4)])) ;
end

% convert to indices "坐标展开" in chinease
c_ = 0:numel(c)-1 ;
c_ = 1 + ...
  mod(c_, sz(1)*sz(2)) + ...
  (sz(1)*sz(2)) * c(:)' + ...
  (sz(1)*sz(2)*sz(3)) * floor(c_/(sz(1)*sz(2))) ;

% compute softmaxloss

Xmax = max(X,[],3) ;
% size(ex) isequal to [1 1 5 10] 
% it's like exp{I(y_i = j) - p(y_i=j)}
ex = exp(bsxfun(@minus, X, Xmax)) ; 

% log(sum(ex,3)) is the loss 
n = sz(1)*sz(2);
if nargin <= 2
  t = Xmax + log(sum(ex,3)) - reshape(X(c_), [sz(1:2) 1 sz(4)]) ;
  Y = sum(t(:)) / n ;
else
  Y = bsxfun(@rdivide, ex, sum(ex,3)) ;
  Y(c_) = Y(c_) - 1;
  Y = Y * (dzdy / n) ;
end
