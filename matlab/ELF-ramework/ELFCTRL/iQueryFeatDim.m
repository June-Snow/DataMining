function dim = iQueryFeatDim(method)

%% ����ά��
switch method
    case 'svm', dim = 1;
    case 'cnn', dim = 2; 
end
end