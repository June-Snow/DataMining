function [ folder ] = olGetFolder( strdir )

%%
folder = {};
fs = dir(strdir);
count = 1;
for i = 1 : length(fs)
    if fs(i).isdir && ~strcmp(fs(i).name, '.') && ~strcmp(fs(i).name, '..')
        folder{count} = fs(i).name;
        count = count + 1;
    end
end

end

