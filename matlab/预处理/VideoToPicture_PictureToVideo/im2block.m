function  blocks = im2block(image, save_path, sz, stride, image_stype)
%%
blk_size=sz;
[M N K] = size(image);
blocks = [];

for r = blk_size/2+1 : stride : M-blk_size/2
    for c = blk_size/2+1 : stride : N-blk_size/2
        blk = image(r-blk_size/2 : r+blk_size/2-1, c-blk_size/2 : c+blk_size/2-1, : );
        blocks( : , : , : , end+1) = blk;
        imwrite(blk, strcat( save_path, num2str(r), num2str(c), '.', image_stype));
    end
end

end
