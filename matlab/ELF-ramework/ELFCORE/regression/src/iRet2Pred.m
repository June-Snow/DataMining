function [pred] = iRet2Pred(res)

%%
[~, ind] =  max(res, [ ], 3);
%pred = squeeze(ind)';
pred = squeeze(ind);
end