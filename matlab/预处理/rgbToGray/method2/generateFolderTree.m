function [folders] = generateFolderTree( root)
%%
if nargin ==1
    exclude_folder = [];
end

path = root;
files = dir(root);

folders = {};
for i = 3 : length(files)
    if ~isdir([root '\' files(i).name])% || sum(exclude_folder == files(i).name)~=0
       continue;
    else
         sub_folder = [root '\' files(i).name];
        folders{end+1} = sub_folder;
    end
    new_folders = generateFolderTree(sub_folder);%, exclude_folder);
    folders = [folders, new_folders];    
end

end