function ret = olCmp(a, b)
%%
% TODO : handle more Type
% ret: 1 : meaning different 
%      0 : meaning all stay same
% strcmp return true(1) if both are same
STAYSAME = 0;
NOTSAME = 1;

if ~strcmp(class(a), class(b))
    ret = NOTSAME;
    return;
end

if iscell(a)
    ret = cellcmp(a, b);
end

if ischar(a)
    ret = ~strcmp(a, b);
end

if isnumeric(a)
    ret = ~(a==b);
end
end

function ret = cellcmp(cellA, cellB)
%%
% TODO : handle more Type
% ret: 1 : meaning different 
%      0 : meaning all stay same
% strcmp return true(1) if both are same
STAYSAME = 0;
NOTSAME = 1;
if length(cellA) ~= length(cellB)
    ret = NOTSAME;
    return ;
end
ret = cellfun(@(x, y) strcmp(x, y), cellA, cellB);
ret = sum(~ret(:));
end