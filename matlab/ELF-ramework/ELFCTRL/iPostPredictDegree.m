function degree = iPostPredictDegree(prop, pred)

%% 图片属于不同类型的概率
for i = 1 : length(pred)
    degree(i) = mean(cellfun(@(x) x(pred(i)), prop));
end

end