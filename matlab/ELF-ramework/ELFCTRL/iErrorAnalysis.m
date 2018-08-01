function iErrorAnalysis(dataPath, label, pred, nClass)

%% TODO:
K = nClass;

img = cell(K, K);

for i = 1 : length(dataPath)
    img_ = readDataToImg(dataPath{i});
    thumbnail = imresize(img_, [32,32]);
    img{label(i), pred(i)} = cat(4, img{label(i), pred(i)}, thumbnail);
end


count = 1;
for i = 1 : K
    for j = 1 : K
             
        if isempty(img{i,j})
            continue;
        end
        
        subplot(K,K,count);
        olDisplayFilter(double(img{i,j}));
      
        titleStr = sprintf('Class %d to %d', i, j);
        title(titleStr);
        count = count + 1;
    end
end

end