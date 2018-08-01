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
    ind = randperm(numel(trainInd));%���������������
    trainInd = trainInd(ind);
    
    [feature, label] = getBatch(imdb, trainInd) ;%�������������ļ�
    
    [pred, speed, model, layerRet] = ELFSvmTrain(model, feature, label, layerRet);

    for i = 1 : length(feature)
        guiLabel(i) = label(trainInd(ind(i)));
        guiPred(i) = pred(trainInd(ind(i)));
    end
    
    [wholeErr, classErr] =  iCalcError(guiLabel, guiPred);%����ѵ�����������ʡ�׼ȷ��
    errRecord = [errRecord, [wholeErr; classErr]];
    
    iShow(errRecord, label, pred, imdb.class, trainInd);
end
end