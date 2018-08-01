function [featImdb, getBatchHandle]= ELFPipeLineFeature(featName, pathes, label, class, dim, datamode, traintestmode)

%%
bs = 256 ;
 
switch upper(datamode)
    case 'MEMORYMODE'
        getBatchHandle = iGetBatchWrapper(datamode, [] ,[]) ;
        featImdb = ELFExtractFeature(featName, pathes, dim, traintestmode);

        [meanV, stdV] = iMeanVar(featImdb.feature);
        featImdb.feature = iNormarlizeData(featImdb.feature, meanV, stdV);
        featImdb.meanV = meanV;
        featImdb.stdV = stdV;
        featImdb.label = label;
        featImdb.class = class;
        
    case 'DISKMODE'
        nSample = length(label);
        featHandle = @(pathes) ELFExtractFeature(featName, pathes, dim, traintestmode);
        getBatchHandle = iGetBatchWrapper(datamode, featHandle, [], []) ;
        im = [];
        for t = 1 : bs : nSample
            batch = (t:min(t+bs-1, nSample)) ;
            temp = getBatchHandle(pathes, label,  batch) ;
            im = cat(4, im, mean(cat(4, temp{:}),4)) ;
        end
        featImdb.meanV = mean(im, 4) ;
   
        minValue = [];
        for t = 1 : bs : nSample
            batch = (t:min(t+bs-1, nSample)) ;
            temp = getBatchHandle(pathes, label, batch) ;
            xminMean = arrayfun(@(x) temp{x}-featImdb.meanV, ...
                1:length(temp),'UniformOutput', false);
            sumXminMean = sum(cat(4, xminMean{:}).^2, 4);
            minValue = cat(4, minValue, sumXminMean);
        end
        temp = sum(minValue, 4);
        
        featImdb.stdV = sqrt((temp) / (nSample-1));
        featImdb.label = label;
        featImdb.class = class;
        featImdb.feature = pathes;
        getBatchHandle = iGetBatchWrapper(datamode, featHandle, featImdb.meanV, featImdb.stdV) ;
    otherwise
end
end





