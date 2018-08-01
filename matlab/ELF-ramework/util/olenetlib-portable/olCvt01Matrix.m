function [ma] = olCvt01Matrix(vec, sz)

%%
len = sz(2);
% ma = full(sparse(vec, 1:len, 1));

ma = zeros(sz, 'single');
for i = 1 : len
    ma(vec(i), i) = 1;
end

end