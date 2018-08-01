function [pred, speed, newNet, layerRet] = ELFCnnTrain(net, feature, label, layerRet, trainType, getBatch)

%%
global DEBUG;

%%
root = fileparts(mfilename('fullpath')) ;
if trainType == 1
    configPath = [root filesep 'elf_config_train.ini'];%CNN模型路径
end
if trainType == 2
    configPath = [root filesep 'elf_config_train.ini'];%CNN模型路径
end

weightDecay = 0.0005 ;
momentum = 0.9 ;

useGpu = 1;
trainConf = iLoadConfigCnn(configPath);
batchSize = trainConf.batchSize;

pred =[];
err = [];

if isempty(net)
    layerRet.err = [];
    [featureCell, ~] = getBatch(feature, label, 1);
    net = iInitModel(trainConf.modelPath, trainConf.algo, max(label), ...
        size(featureCell{1}, 3), trainConf.useGpu);
end


%%
nFeature = length(feature);
net.learningRate = iAdjustLRate(net.learningRate, layerRet(end).err);
lr = net.learningRate;
% lr = net.learningRate(randi(length(net.learningRate))) ;
net.lr(end+1) = lr;
randIdx = randperm(length(label));

for i = 1 : batchSize : nFeature
    batch_time = tic ;
    batch = randIdx(i : min(i+batchSize-1, nFeature));
     
    [featureCellBatch, labelBatch]= getBatch(feature, label, batch);
    
    net.layers{end}.class = labelBatch ;
    featureBatch = iFeature2DFeed(featureCellBatch);
    layerRet = vl_simplenn(net, featureBatch, 1, layerRet);
    pred = [pred; iRet2Pred(layerRet(end-1).x) ];
    
    for l=1:numel(net.layers)
      if ~strcmp(net.layers{l}.type, 'conv'), continue ; end
        
      net.layers{l}.filtersMomentum = ...
        momentum * net.layers{l}.filtersMomentum ...
          - (lr * net.layers{l}.filtersLearningRate) * ...
          (weightDecay * net.layers{l}.filtersWeightDecay) * net.layers{l}.filters ...
          - (lr * net.layers{l}.filtersLearningRate) / numel(batch) * layerRet(l).dzdw{1} ;

      net.layers{l}.biasesMomentum = ...
        momentum * net.layers{l}.biasesMomentum ...
          - (lr * net.layers{l}.biasesLearningRate) * ....
          (weightDecay * net.layers{l}.biasesWeightDecay) * net.layers{l}.biases ...
          - (lr * net.layers{l}.biasesLearningRate) / numel(batch) * layerRet(l).dzdw{2} ;

      net.layers{l}.filters = net.layers{l}.filters + net.layers{l}.filtersMomentum ;
      net.layers{l}.biases = net.layers{l}.biases + net.layers{l}.biasesMomentum ;
    end
    batch_time = toc(batch_time) ;
    speed = numel(label)/batch_time ;  
end

newNet = net;

pred = olMapRandBack(randIdx, pred);

%%
if DEBUG
    sz = size(net.layers{1}.filters);
    if sz(3) >= 3
        figure(903);
        olDisplayFilter(net.layers{1}.filters);
        net.layers{1}.filters(:,:,1,1);
    end
end

end
