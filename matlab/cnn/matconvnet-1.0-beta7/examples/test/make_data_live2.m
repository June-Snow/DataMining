function make_data_live2()

load('live_exp.mat');
blocks = blocks_exp;
label = label_exp;

n = length(blocks);
index = randperm(n);
blocks = blocks(index, :);
label = label(index, :);


k = 200; % get k patches from each image
for i = 1 : length(blocks)
    n = length(blocks{i, :});
    clear index;
    index = randperm(n, k);
    randblocks{i, :} = blocks{i, index};
end

end