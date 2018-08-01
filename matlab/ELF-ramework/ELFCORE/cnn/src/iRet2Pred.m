function [pred] = iRet2Pred(res, trainType)

%%
if trainType == 1
    [~, ind] =  max(res, [ ], 3);%第三维中的最大值所在的行号;
    pred = squeeze(ind);
elseif trainType == 2
    pred = squeeze(res);
end

end