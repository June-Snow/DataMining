function getBatchHandle = iGetBatchWrapper(mode, featHandle, meanV, stdV)

%%
switch upper(mode)
    case 'MEMORYMODE'
        getBatchHandle = @(imdb, label, batch) iGetBatch(imdb, label, batch);
    case 'DISKMODE'
        getBatchHandle = @(paths, label, batch) iGetBatchDisk(paths, label, batch, featHandle, meanV, stdV);
end
end
