function fileList = olFilterFile(fileList, ext)

%%
if isempty(ext)
    return
end

empty_ind = [];
for i = 1 : length(fileList)
    [~,~,e] = fileparts(fileList{i});
    if isempty(e) || ~strcmp(ext, e) 
        empty_ind = [empty_ind, i];
    end
end
fileList(empty_ind) = [];