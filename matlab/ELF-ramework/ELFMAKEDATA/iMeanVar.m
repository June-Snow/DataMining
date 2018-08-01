function [meanV, stdV] = iMeanVar(dataCell)

%%
nSample = length(dataCell);
featInst = [];
for i = 1 : nSample
    featInst = cat(4, featInst, dataCell{i});    
end
meanV = mean(featInst, 4);
stdV = std(featInst, 0, 4);
end