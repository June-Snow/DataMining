function feature = iRescale(feature, sz)
%%
nFeat = length(feature);
feat = [];
for i = 1 : nFeat
    feat{i} = imresize(feature{i}, sz(1:2));
end
feature = feat;
end