function ret = bayesian_pred(pred_matrix, prior_leaf, prior_normal, prior_leafinleaf, prior_normalinleaf, prior_leafinnormal, prior_normalinnormal)

%% NOTE：预测的模型中，leaf是2，normal是1， 和exp2中的其他对比试验不太一样，切为注意
NORMAL = 1;
LEAF = 2;

% prior_leafinleaf = [] % 3x3
leaf_add_wight = 0.0004;
pleaf = prior_leaf ...
    * prod(prior_leafinleaf(pred_matrix(:)==LEAF)) ...
    * prod(prior_normalinleaf(pred_matrix(:)==NORMAL)) + leaf_add_wight ;


pnormal = prior_normal ...
    * prod(prior_leafinnormal(pred_matrix(:)==LEAF)) ...
    * prod(prior_normalinnormal(pred_matrix(:)==NORMAL));

if pleaf >= pnormal
    ret = LEAF;
else
	ret = NORMAL;
end

end