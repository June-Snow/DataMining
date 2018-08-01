% fine tune vote pooling

[gt, data] = libsvmread('D:/STUDY/[0] ELF-ramework/ELF-ramework/ELF-ramework/_expData/20160112T223247/blkStat.txt');
data = full(data);

[ndata, nblk] = size(data);
LEAF = 2;
NORMAL = 1;
pred = [];
for thresh = 1 : nblk
    for i = 1 : ndata
        if sum(data(i, :)  == LEAF) >= thresh
            pred(i, 1) = LEAF;
        else
            pred(i, 1) = NORMAL;
        end
    end
    fprintf('tresh : %d\n', thresh);
    leaf_ind = (gt==LEAF);
    normal_ind = (gt==NORMAL);
    miss_detect = 1 - sum(pred(leaf_ind) == gt(leaf_ind)) / sum(leaf_ind);
    fprintf('miss detect:%f\n', miss_detect);
    false_alarm = 1 - sum(pred(normal_ind) == gt(normal_ind)) / sum(normal_ind);
    fprintf('false alarm:%f\n\n', false_alarm);
end

