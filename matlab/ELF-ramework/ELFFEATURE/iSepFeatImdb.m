function featImdbSep = iSepFeatImdb(featImdb, sep)
%%
if sep == 1
    featImdbSep = featImdb;
    return ;
end

blocknum = sep^2;
nSample = length(featImdb.feature);
[H, W, K] = size(featImdb.feature{1});
% repInd = arrayfun(@(x) repmat(x, 1, blocknum), 1:nSample);
featImdbSep = [];
featImdbSep.feature = [];
featImdbSep.label = [];
featImdbSep.id = [];
if isfield('featImdb', 'class')   %检查结构体featImdb是否包含由class指定的域
    featImdbSep.class = featImdb.class;
end

for i = 1 : nSample   
    patch = olIm2Patch(featImdb.feature{i}, [floor(H/sep), floor(W/sep)]);
    featImdbSep.feature = cat(1, featImdbSep.feature, patch);
    
    if ~isempty(featImdb.label)
        label = repmat(featImdb.label(i), 1, blocknum);    
        featImdbSep.label = cat(2, featImdbSep.label, label);
    end
    
    id = repmat(i, 1, blocknum);
    featImdbSep.id = cat(2, featImdbSep.id, id);
end

end
