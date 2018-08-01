function [pred, speed, modelBest, layerRet] = ELFSvmTrain(model, feature, label, layerRet)

%%
global DEBUG;

%%
pred =[];
err = [];
errTrain = [];
errVal = [];
layerRet = [];
modelBest = [];


%% Prepare Validation Set
nFeature = length(feature);
valBatch = ceil((4/5)*nFeature) : nFeature;
labelVal = label(valBatch);
featureVal = iFeature2Svm(feature(valBatch));


%% Train and CV
batchSize = nFeature/10;
errValBest = Inf;
count =  1;
nTrain = nFeature-length(valBatch);
for i = 1 : batchSize : nTrain
    batch_time = tic ;
    
    trainBatch = 1 : i; 
    labelBatch = label(trainBatch);
    featureBatch = iFeature2Svm(feature(trainBatch));   
    model = svmtrain(labelBatch', featureBatch, '-c 0.001 -g 0.07 -t 0');% 
    predTrain = svmpredict(labelBatch', featureBatch, model);
    errTrain(count) = iCalcError(labelBatch, predTrain');
    
    predVal = svmpredict(labelVal', featureVal, model);
    errVal(count) = iCalcError(labelVal, predVal');
    
    if errVal(end) < errValBest
        modelBest = model;
    end
    
    batch_time = toc(batch_time) ;
    speed = numel(label)/batch_time ;  
    count = count + 1;
end


%% 
feature = iFeature2Svm(feature);
pred = svmpredict(label', feature, modelBest);
pred = pred';

if DEBUG
    figure(902);
    plot(1:length(errTrain), errTrain, 1:length(errVal), errVal);
    title('cross validation error');
    % pause;
end

end



