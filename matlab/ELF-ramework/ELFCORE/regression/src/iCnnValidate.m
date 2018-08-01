function [net, learningRec] = iCnnValidate(net, im, label, useGpu)

%%
layerRet = [] ;

net.layers{end}.class = label ;
layerRet = vl_simplenn(net, im, [], layerRet, ...
    'disableDropout', true) ;

learningRec = iCalcError(net, layerRet) ;
% learningRec = voteRes(learningRec, layerRet);

end

