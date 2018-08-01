function Y = elf_scoreloss(X,c,dzdy)

% %X = X + 1e-6 ;
% sz = [size(X,1) size(X,2) size(X,3) size(X,4)] ;
% 
% % index from 0
% c = c - 1 ;
% 
% if numel(c) == sz(4)
%   % one label per image
%   c = reshape(c, [1 1 1 sz(4)]) ;
%   c = repmat(c, [sz(1) sz(2)]) ;
% else
%   % one label per spatial location
%   sz_ = size(c) ;
%   assert(isequal(sz_, [sz(1) sz(2) 1 sz(4)])) ;
% end
% 
% % convert to indices
% c_ = 0:numel(c)-1 ;
% c_ = 1 + ...
%   mod(c_, sz(1)*sz(2)) + ...
%   (sz(1)*sz(2)) * c(:)' + ...
%   (sz(1)*sz(2)*sz(3)) * floor(c_/(sz(1)*sz(2))) ;
% 
% % compute softmaxloss
% Xmax = max(X,[],3) ;
% ex = exp(bsxfun(@minus, X, Xmax)) ;
% 
% n = sz(1)*sz(2);
% if nargin <= 2
%   t = Xmax + log(sum(ex,3)) - reshape(X(c_), [sz(1:2) 1 sz(4)]) ;
%   Y = sum(t(:)) / n ;
% else
%   Y = bsxfun(@rdivide, ex, sum(ex,3)) ;
%   Y(c_) = Y(c_) - 1;
%   Y = Y * (dzdy / n) ;
% end
sz_ = size(c) ;
t = X(:) - c(:) ;
Y = sum(t(:)) / (sz_(1)*sz_(2));

end













