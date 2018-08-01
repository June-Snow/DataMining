function oriVector = olMapRandBack(randIdx, vector)

%% 训练样本打乱循序，标签相应跟着变换
ndim = ndims(vector);%数组维数
nVector = length(vector);

if ndim == 2
    num = size(vector, ndim);
    for i = 1 : num
        vector_tmp{i} = vector(:,i);
    end
    vector = vector_tmp;
end

if ndim ==4
    num = size(vector, ndim);
    for i = 1 : num
        vector_tmp{i} = vector(:,:,:,i);
    end
    vector = vector_tmp;
end

%oriVectorC = cell(size(vector));
oriVectorC = cell(size(vector{1,1}));
for i = 1 : nVector 
    %oriVectorC(randIdx(i)) = vector(i);
    oriVectorC{randIdx(i), 1} = vector{1,1}(i);
end

oriVector = [];
for i = 1 : nVector
    oriVector = cat(ndim, oriVector, oriVectorC{i});
end

end

