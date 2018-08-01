function dim = iQueryFeatDim(method)

%% ·µ»ØÎ¬¶È
switch method
    case 'svm', dim = 1;
    case 'cnn', dim = 2; 
end
end