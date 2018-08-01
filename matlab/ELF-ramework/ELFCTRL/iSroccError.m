function err = iSroccError(label, pred)
%% SROCCֵ

len = length(label);
[~, indexLabel] = sort(label);
[~, indexPred] = sort(pred);
srocc = 1 - 6*(sum((indexLabel - indexPred).^2))/(len * (len.^2 - 1));
err = 1 - abs(srocc);

end