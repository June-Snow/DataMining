function [error] = iNaiveError(pred, label)

%%
% predictions = gather(res(end-1).x) ;
% sz = size(predictions) ;
% n = prod(sz(1:2)) ;

% [~, predictions] = sort(predictions, 3, 'descend') ;

error = ~bsxfun(@eq, pred, reshape(label, 1, 1, 1, [])) ;
%;/���һ�������������һ�㲻��[1 1 m k]�Ļ�������[ 3 3 m k],�Ǿͳ�3*3��
%������Ϊ����û�������������ݣ������������ݲ���[1 1 m k]��Ӧ���Ǻܷ�������ƣ�
%��һ���׶�ʵ��; % ???? 
error = sum(sum(sum(error(:,:,1,:))));

end
