function [feat] = iFeature2DFeed(feature)

%% ������ת��Ϊ���������������ʽ
feat = [];
nFeature = numel(feature);%��������������ָ��������Ԫ�ظ���
ft = feature{1};
[D, M] = size(ft);

for i = 1 : nFeature
        feat = cat(4, feat, single(feature{i}));
end

end
