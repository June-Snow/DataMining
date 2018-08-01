[label, inst] = libsvmread('_expData/20150618T090343/blkStat.txt');
inst = full(inst);

for i = 1 : size(inst, 1)
    pred2(i) = iPostPredictPred(inst(i, :));
end
Equal = sum(label == pred2');
fprintf('acc: %f \n', Equal/size(inst, 1));

sz = [5, length(label)];
plotconfusion(olCvt01Matrix(label, sz), olCvt01Matrix(pred2, sz));