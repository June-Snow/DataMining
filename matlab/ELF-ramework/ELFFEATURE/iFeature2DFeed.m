function [feat] = iFeature2DFeed(feature)

%% 把特征转换为输入网络的特征格式
feat = [];
nFeature = numel(feature);%计算数组中满足指定条件的元素个数
ft = feature{1};
[D, M] = size(ft);

for i = 1 : nFeature
        feat = cat(4, feat, single(feature{i}));
end

end
