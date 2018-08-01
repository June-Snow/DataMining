function c = olStr2cell(s, delimiter)

%%
if nargin == 1
    delimiter = ',';
end

%%
c = regexp(s, delimiter, 'split');
c = cellfun(@(x) strtrim(x), c, 'UniformOutput', false);