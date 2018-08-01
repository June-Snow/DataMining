function ret = bayesian_pred(pred_matrix, prior_leaf, prior_normal, prior_leafinleaf, prior_normalinleaf, prior_leafinnormal, prior_normalinnormal)

%% NOTE��Ԥ���ģ���У�leaf��2��normal��1�� ��exp2�е������Ա����鲻̫һ������Ϊע��
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