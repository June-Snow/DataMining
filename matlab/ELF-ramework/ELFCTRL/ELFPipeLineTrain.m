function  [model] = ELFPipeLineTrain(rawImdb, featName, iniInfo, dim, traintestmode, trainType)

%% Declare
clc;
model = [];
errRecord = [];
trainRet=[];
SAVE = 1;
nClass = length(rawImdb.class);
% expDir = '_expData';
expDir = fullfile('_expData', datestr(now, 30));
olInitDir(expDir);
nSample = length(rawImdb.relPath);
errThresh = 0.001;


%%
pathes = arrayfun(@(x) fullfile(rawImdb.rawDataDir, rawImdb.relPath{x}),...
    1:nSample, 'UniformOutput', false);%得到所有样本全路径
label = rawImdb.label;
class = rawImdb.class;
datamode = iniInfo.data.mode;
[featImdb, getBatchHandle]= ELFPipeLineFeature(featName, pathes, label, class, dim, datamode, traintestmode);%计算样本特征


%% Train
tic;

rng(0);
bestErr = inf;
bestRoc = inf;
h = figure(201);
bglogo = imread('512bglogo.bmp');
imshow(bglogo);drawnow;
%循环训练计算出最好的模型
numEpoch = iniInfo.train.numEpoch;
for epoch = 1 : numEpoch
    
    [pred, speed, model, trainRet] = ELFCnnTrain(model, featImdb.feature, ...
        featImdb.label, trainRet, trainType, getBatchHandle);%得到样本特征后，进行训练
    label = featImdb.label;
    
    if trainType == 1
        [err, rocVal] =  iCalcError(label, pred, nClass);%err:1.总错误率，2.第一类错误率，3.第二类错误率
    elseif trainType == 2
        err = iSroccError(label, pred);
    end
    errRecord = [errRecord, err];
    trainRet(end).err = errRecord(1, :);
    
    % save
    model.meanV = featImdb.meanV;
    model.stdV = featImdb.stdV;
    model.featName = featName;
    model.class = rawImdb.class;
    save(fullfile(expDir, ['model-',num2str(trainType),num2str(epoch), '.mat']), '-struct', 'model');
    
    if trainType == 1
        ELFShow(h, label, pred, nClass, featImdb.class, errRecord, numEpoch);
    elseif trainType == 2
        ELFSroccShow(h, label, pred, errRecord, numEpoch);
    end
    
    if err(1) < bestErr
        save(fullfile(expDir, ['model-',num2str(trainType),'bestErr.mat']), '-struct', 'model');
        if ishandle(201), saveas(201, fullfile(expDir, '201-bestErr.fig')), end;
        
        bestErr = err(1);
        bestModel = model;
        bestModel.meanV = featImdb.meanV;
        bestModel.stdV = featImdb.stdV;
    end
%     
%     if trainType == 1 && rocVal < bestRoc
%         save(fullfile(expDir, ['model',num2str(trainType),'-bestRoc.mat']), '-struct', 'model');
%         if ishandle(201), saveas(201, fullfile(expDir, '201-bestRoc.fig')), end;
%     end
   
    if bestErr < errThresh  %|| (trainRet(end).errTr > trainRet(end).errVa)
        break;
    end
end
if ishandle(201), saveas(201, fullfile(expDir, '201.fig')), end;
if ishandle(202), saveas(202, fullfile(expDir, '202.fig')), end;
if ishandle(903), saveas(903, fullfile(expDir, '903.fig')), end;
toc

%% Save and uninitialize
% if (bestErr < 0.1 || SAVE == 1) && ~isempty(expDir)
% copyfile(iniInfo.iniPath, [expDir, '/']);
% save(fullfile(expDir, 'rawImdb.mat'), '-struct', 'rawImdb');
% end

iUnInitialize(iniInfo);
end

