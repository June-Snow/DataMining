function [x] = olCheckValid(x)

%%
if isempty(x)    
    x = -1000;
end