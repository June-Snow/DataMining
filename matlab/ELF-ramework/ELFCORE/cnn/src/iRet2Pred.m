function [pred] = iRet2Pred(res, trainType)

%%
if trainType == 1
    [~, ind] =  max(res, [ ], 3);%����ά�е����ֵ���ڵ��к�;
    pred = squeeze(ind);
elseif trainType == 2
    pred = squeeze(res);
end

end