function final_folderfullpath = finalFolderTree(folders)
% final_folderfullpath is the folder that has images
% the parameter folders is that the all foldway, contain the middle path

final_folderfullpath = {};

count = 0;

for i = 1 : length(folders)
    tree = cellfun(@(x) dir(x), folders,'UniformOutput',false);
    if(length(tree{1,i}) > 2)
        if(isdir(tree{1,i}(3).name) == 1)
            continue;
        else
            count = count + 1;
            final_folderfullpath(count) = folders(i);
        end
%     else
%         count = count + 1;
%         final_folderfullpath(count) = folders(i);
    end
    
end
