function feed = iFeature1DFeed(feature)

%%
nFeature = numel(feature);

% TODO: opencv存储图像是行优先， matlab列优先
% TODO: 隐患：块不是正方块
ft = feature{1};
[D, M] = size(ft);
% fo = zeros(sqrt(M), sqrt(M), D, num, 'single');
fo = [];
for i = 1 : nFeature
    fo = cat(4, fo, feature{i});
%     for j = 1 : D
%         fo(:, :, j, i) = double(reshape(feature{i}(j, :), [sqrt(M), sqrt(M)]));
%     end
end
feed = single(cell2mat(fo));

end
