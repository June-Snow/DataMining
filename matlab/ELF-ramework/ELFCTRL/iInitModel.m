function model = iInitModel(modelPath, algo, nLabel, nFeatureDim, useGpu)
%% ��ʼ��CNNģ��

switch lower(algo)
    case 'cnn'
        modelFunName = olGetNameNoExt(modelPath);%�õ�����ģ�ͣ�model/cnn��������ģ���е�һ��
        model = feval(modelFunName, nLabel,nFeatureDim,useGpu);%�õ�ѵ��ģ��

end

end
