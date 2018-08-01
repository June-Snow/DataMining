function fileList = olGetAllFile(dirName, varargin)

%%
p = inputParser;
defaultExt = '';
addOptional(p,'ext',defaultExt);
parse(p, varargin{:});
ext = p.Results.ext;

%%
dirData = dir(dirName);
dirIndex = [dirData.isdir];

fileList = olFilterFile({dirData(~dirIndex).name}', ext);

if ~isempty(fileList)
    fileList = cellfun(@(x) ([dirName '/' x]),...
        fileList,'UniformOutput',false);
end
subDirs = {dirData(dirIndex).name};
validIndex = ~ismember(subDirs,{'.','..'});% TO IGNORE '.' or '..'

for iDir = find(validIndex)
    nextDir = fullfile(dirName,subDirs{iDir});
	fprintf('Parsing %s\n',nextDir);
    fileList = [fileList; olGetAllFile(nextDir, 'ext', ext)];
end