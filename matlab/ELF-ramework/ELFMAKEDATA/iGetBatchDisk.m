function [featCell, labelbatch] = iGetBatchDisk(pathes, label, batch, procFn, meanV, stdV)

%%
pathbatch = pathes(batch);
labelbatch = label(batch);
featImdb = procFn(pathbatch);
featCell = featImdb.feature;
if ~isempty(meanV) && ~isempty(stdV)
    featCell = iNormarlizeData(featCell, meanV, stdV);
end

end