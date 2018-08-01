function [pred] = ELFSvmPredict(model, feature)

%%
nFeature = length(feature);
feature = iFeature2Svm(feature);
pred = svmpredict(zeros([nFeature,1]), feature, model);

end