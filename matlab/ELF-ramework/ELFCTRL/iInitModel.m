function model = iInitModel(modelPath, algo, nLabel, nFeatureDim, useGpu)
%% 初始化CNN模型

switch lower(algo)
    case 'cnn'
        modelFunName = olGetNameNoExt(modelPath);%得到网络模型，model/cnn下四网络模型中的一个
        model = feval(modelFunName, nLabel,nFeatureDim,useGpu);%得到训练模型

end

end
