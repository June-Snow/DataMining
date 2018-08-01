function [error] = iNaiveError(pred, label)

%%
% predictions = gather(res(end-1).x) ;
% sz = size(predictions) ;
% n = prod(sz(1:2)) ;

% [~, predictions] = sort(predictions, 3, 'descend') ;

error = ~bsxfun(@eq, pred, reshape(label, 1, 1, 1, [])) ;
%;/最后一层输出，如果最后一层不是[1 1 m k]的话，比如[ 3 3 m k],那就除3*3，
%这是因为网络没有适配输入数据，导致最后的数据不是[1 1 m k]，应该是很泛化的设计，
%下一个阶段实现; % ???? 
error = sum(sum(sum(error(:,:,1,:))));

end
