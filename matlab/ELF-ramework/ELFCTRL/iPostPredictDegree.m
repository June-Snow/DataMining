function degree = iPostPredictDegree(prop, pred)

%% ͼƬ���ڲ�ͬ���͵ĸ���
for i = 1 : length(pred)
    degree(i) = mean(cellfun(@(x) x(pred(i)), prop));
end

end