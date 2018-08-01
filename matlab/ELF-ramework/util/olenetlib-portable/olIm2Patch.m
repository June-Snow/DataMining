function patchCell = olIm2Patch(img, sz, stride)

%%
if nargin == 2
    stride = sz;
end

blk_size = floor(sz);
[M, N, K] = size(img);
patch_num = floor((M - blk_size(1))/stride(1) + 1) * floor((N - blk_size(2)) / stride(2) +1);
patchCell = cell(patch_num, 1);

count = 1;
for r = 1 : floor(stride(1)) : M
    for c = 1 : floor(stride(2)) : N
        if (r+blk_size(1)-1)>M || c+blk_size(2)-1>N
            continue;
        end
        
        blk = img(...
            r : r+blk_size(1)-1,...
            c : c+blk_size(2)-1, ...
            :);
        patchCell{count,1} = blk;
        count = count + 1;
    end
end

% patchArray = cat(4, patchCell{:});
end