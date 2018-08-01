function rawImdb = iSepData(rawImdb, sep)

%%
if sep == 1
    return
end

blocknum = sep^2;
nSample = length(rawImdb.relPath);
repInd = arrayfun(@(x) repmat(x, 1, blocknum), 1:nSample);

names = fieldnames(rawImdb);
rawImdbSep = [];
for i = 1 : nSample
    for j = 1 : names
        field = names(j);
        rawImdbSep.(field) = rawImdb.(field);
    end
end

for i = 1 : nSample
    rawImdbSep.relPath(i) = [rawImdbSep.relPath(i), num2str(repInd(i))];
end
end