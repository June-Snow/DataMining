function iResultAnalysis()

%%
clc;
clear;

%% Collect Info
customMem = 'mem.mat';
if exist(customMem, 'file')
    load(customMem);
    [resultPath] = promptMem(resultPath, 'result data', customMem);
    [modelPath] = promptMem(modelPath, 'model', customMem);
else
    [resultPath] = promptMem('', 'result data', customMem);
    [modelPath] = promptMem('', 'model', customMem);
end

fprintf('reading result data...\n');
[label, pred, rawDataDir, relPath] = loadResult(resultPath);

fprintf('loading model ...\n');
model = loadModel(modelPath);

save(customMem, 'resultPath', 'modelPath');


%% Show 
h = figure(204);
ELFShow(h, label, pred, length(model.class));
f1score = olF1score(label, pred);
display(sprintf('f1score : %f', f1score));


%% Transfer data
prompt = sprintf( 'Do you want to transfer data? (Y/n): ');
tranderyn = input(prompt, 's');

TRANSFER = 0;
if (isempty(tranderyn) || tranderyn(1) == 'Y' || tranderyn(1) == 'y')
    TRANSFER = 1;
    prompt = sprintf( ...
    'Copy(input 1)? Move(input 2)? Delete(input 3)?');
    mode = input(prompt, 's');
end

if TRANSFER % zeros(1, length(pred)) + normalLabel
    iTransferData(label, pred, rawDataDir, relPath, str2double(mode(1)));
end


%%
h = figure(1);
nSample = length(pred);
for i = 1 : nSample
    if pred(i) ~= 3
        fullpath = fullfile(rawDataDir, relPath{i});
        aviObj = VideoReader(fullpath);
        frame = read(aviObj, 1);
        imshow(frame);
        hxl = xlabel([num2str(i) ':' fullpath]);
        set(hxl, 'interpreter', 'none');
        title(['Pred:', model.class{pred(i)}]);
        pause();
    end
end
end


%% 
%--------------------------------------------------------------------------
function [label, pred, rawDataDir, relPath] = loadResult(filepath)
%--------------------------------------------------------------------------
if ~exist(filepath, 'file') || isempty(filepath)
    error('filepath is empty or do not exist!');
end

prompt = sprintf( 'Old Style File? (Y/n): ');
oldyn = input(prompt, 's');

count = 1;
fid = fopen(filepath);
rawDataDir = fgetl(fid);

while  ~feof(fid)
    tline = fgetl(fid);
    if isempty(tline)      %判断是不是空行
        continue
    end

    if lower(oldyn) == 'y'
        [predStr, relPath_] = strtok(tline);
        relPath{count} = strtrim(relPath_);
        
        label(count) = 1;
        pred(count) = str2double(predStr);   
    else
        [labelStr, temp] = strtok(tline);
        [predStr, relPath_] = strtok(temp);
        relPath{count} = strtrim(relPath_);
        label(count) = str2double(labelStr);
        pred(count) = str2double(predStr);   
    end
    count = count + 1;
end
fclose(fid);

if strcmp(filepath, 'D:\STUDY\[0] ELF-ramework\ELF-ramework\ELF-ramework\_expData\20150519T172935\data.txt')
    label = [ones(1,49-2+1),  ones(1,69-50+1)+1, ones(1, 9658-70+1)+2, ones(1, 9798-9659+1)+3, ones(1, 10151-9799+1)+4];
end

end


%%
%--------------------------------------------------------------------------
function model = loadModel(modelPath)
%--------------------------------------------------------------------------
if ~exist(modelPath, 'file') || isempty(modelPath)
    error('filepath is empty or do not exist!');
end

model = load(modelPath);
end


%%
%--------------------------------------------------------------------------
function [item] = promptMem(existItem, itemName, customMemFile)
%--------------------------------------------------------------------------

if (~isempty(existItem) )
    prompt = sprintf( ...
        'Use %s from last configuration(%s)? (Y/n): ', ...
        itemName, existItem);
    
    useyn = input(prompt, 's');
    
    if (isempty(useyn) || useyn(1) == 'Y' || useyn(1) == 'y')
        item = existItem;
        return;   
    end
   
end

prompt = sprintf( 'Input  %s : ', itemName);
item = input(prompt, 's');
end

