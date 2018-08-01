function [a, freq]= maxFreq(arr)

%%
stat = tabulate(arr(:));
     [~, ind] = max(stat(:,3));
     a = stat(ind(1), 1);
     freq = stat(ind(1), 3);
end