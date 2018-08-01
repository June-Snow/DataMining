function [ colName, tableData ] = iUiDataInfo(rawDataDirStr, relPathCellArray)

%%
filelist = arrayfun(@(x) fullfile(rawDataDirStr, relPathCellArray{x}), 1:length(relPathCellArray), 'UniformOutput', false);

colName = {'ID', 'path'};

var = [];
for i = 1:length(filelist)
    var = [var; cellstr(num2str(i))];
end
tableData = cat(2, var, filelist');

end