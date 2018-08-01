function Y = vl_nnregressionloss(X, c, dzdy)
%EUCLIDEANLOSS Summary of this function goes here
%   Detailed explanation goes here

assert(numel(X) == numel(c));

sz = [size(X,1) size(X,2) size(X,3) size(X,4)] ;

if numel(c) == sz(4)
    % one label per image
    c = reshape(c, [1 1 1 sz(4)]) ;
    c = repmat(c, [sz(1) sz(2)]) ;
else
    % one label per spatial location
    sz_ = size(c) ;
    assert(isequal(sz_, [sz(1) sz(2) 1 sz(4)])) ;
end

if nargin == 2 || (nargin == 3 && isempty(dzdy))
    Y = 1 / 2 * ((X - c) .^ 2);    
    
elseif nargin == 3 && ~isempty(dzdy)    
    Y = +squeeze(dzdy)'.*((squeeze(X)'-squeeze(c)'));
    Y = reshape(Y,size(X));
    
end

end