function nData = iNormarlizeData(dataCell, meanV, stdV)

%%
epsilon = 1e-12;
nData = dataCell;
nSample = length(dataCell);
for i = 1 : nSample
    nData{i} = (dataCell{i}-meanV) ./ (stdV+epsilon);
end

end