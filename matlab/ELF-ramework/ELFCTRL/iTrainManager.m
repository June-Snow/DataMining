function [model] = iTrainManager(imdb, numEpoch)

%% proc
model = [];
errRecord = [];
guiLabel = [];
guiPred = [];
trainInd = find(imdb.set == 1);
layerRet=[];

%%
rng(0);
for epoch = 1 : numEpoch
    ind = randperm(numel(trainInd));%随机打乱数字序列
    trainInd = trainInd(ind);
    
    [feature, label] = getBatch(imdb, trainInd) ;%并行批处理多个文件
    
    [pred, speed, model, layerRet] = ELFSvmTrain(model, feature, label, layerRet);

    for i = 1 : length(feature)
        guiLabel(i) = label(trainInd(ind(i)));
        guiPred(i) = pred(trainInd(ind(i)));
    end
    
    [wholeErr, classErr] =  iCalcError(guiLabel, guiPred);%计算训练结果的误差率、准确率
    errRecord = [errRecord, [wholeErr; classErr]];
    
    iShow(errRecord, label, pred, imdb.class, trainInd);
end
end