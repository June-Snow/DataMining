function folder = parseTarFolder(folderstr)

%%
folder = regexp(folderstr, ',', 'split');
folder = cellfun(@(x) strtrim(x), folder, 'UniformOutput', false); 

end

