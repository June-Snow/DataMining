ret_file = '.\_expData\20160903T213841\20160904T155950\blkStat.txt';
[gt, pred_blk] = libsvmread(ret_file);

clc
fid = fopen('.\_expData\20160903T213841\20160904T155950\pred_stat.txt', 'w');

for prior_leaf = 0.10 : 0.01 : 0.3
% prior_leaf = 0.2;
% prior_normal = 0.8;
prior_normal = 1 - prior_leaf;
fprintf(fid, '\tprior_normal: %f\n', prior_normal);

prior_leafinleaf = dlmread('.\ELFBAYESIAN\.seg_leaf-median.txt');
prior_normalinleaf = 1 - prior_leafinleaf; % 3x3

prior_leafinnormal =dlmread('.\ELFBAYESIAN\.seg_normal-median.txt');
prior_normalinnormal = 1 - prior_leafinnormal; % 3x3

pred_blk = full(pred_blk);

pred_record = [];
for i = 1 : length(gt)
    blk_stat = reshape(pred_blk(i, :), [3,3]);
    pred = bayesian_pred(blk_stat, ...
                    prior_leaf, prior_normal, ...
                    prior_leafinleaf, prior_normalinleaf, ...
                    prior_leafinnormal, prior_normalinnormal);
    pred_record(i, 1) = pred;
end

acc = sum(pred_record == gt) / length(gt);

NORMAL = 1;
LEAF = 2;
fprintf(fid, '©����(miss detection, ��Ƶ���ڵ�����û�м�������:\n');
leafind = (gt == LEAF);
detected_leaf = sum(pred_record(leafind) == gt(leafind)) / length(gt(leafind));
fprintf(fid, 'miss detect:%f\n', 1 - detected_leaf);

fprintf(fid, '����(false alarm,��Ƶû���ڵ����Ǽ����ڵ���:\n');
normalind = (gt == NORMAL);
detected_normal = sum(pred_record(normalind) == gt(normalind)) / length(gt(normalind));
fprintf(fid, 'false alarm:%f\n\n', 1 - detected_normal);
fprintf(fid, '\n\t');

if (1 - detected_normal +  1 - detected_leaf) < (0.1129+0.1166) % ����ıȽ����ֲμ�ʵ����ܱ�
    fprintf('attention! �ý������VOTE POOLING ���!\n');

    fprintf('©����(miss detection, ��Ƶ���ڵ�����û�м�������:\n');
    fprintf('miss detect:%f\n', 1 - detected_leaf);   
    fprintf('����(false alarm,��Ƶû���ڵ����Ǽ����ڵ���:\n');
    fprintf('false alarm:%f\n', 1 - detected_normal);
    fprintf('Press any key to continue ... \n\n', 1 - detected_normal);
    
    pause
end

end

fclose(fid);