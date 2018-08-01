function [err , pred] = iPredictManager( imdb, model, trainConfig)

%% declare TODO:
trainOpts = iLoadConfigCnn(trainConfig);%初始化CNN训练参数
batchSize = 200;

%% proc
testInd = find(imdb.set == 2);
predEpoch = [];
rec = initLearningRec();
for t = 1 : batchSize : numel(testInd)
     rec = appendLearningRec(rec);
     batch = testInd(t:min(t+batchSize-1, numel(testInd)));
    [feature, label] = getBatch(imdb, batch, trainOpts.useGpu) ;
    [pred, speed, model] = ELFCnnPredict(model, feature, label, trainOpts.useGpu);

    err = iCalcError(label, pred);
    rec.speed(end) = rec.speed(end) + speed;
    rec.error(end) = rec.error(end) + err;
    
    predEpoch = [predEpoch, pred];
end 

pred = predEpoch;
err  = rec.error(end) / numel(testInd) ;
% iSaveSnapShort(tempDir, model, learningRec);
end

