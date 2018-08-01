function [err, dist] = iCalcError(label, pred, nClass)

%% ����rocֵ
index1 = find(label == label(1));
index2 = find(label == label(end));

TP = length(find(pred(index1) == label(1)));
FN = length(find(pred(index1) == label(end)));

FP = length(find(pred(index2) == label(1)));
TN = length(find(pred(index2) == label(end)));

TPR = TP/(TP + FN);
FPR = FP/(FP + TN);

dist = sqrt(FPR*FPR + (1-TPR).^2);

%% ���㵱ǰѵ������Ĵ�����
sz = [nClass, length(label)];
label01 = olCvt01Matrix(label, sz);
pred01 = olCvt01Matrix(pred, sz);

[err, confusionMatrix, confusionInd, rates] = confusion(label01, pred01);%per�ļ��㷽����ÿ����ִ����/��������
totalInd=cellfun(@(x) numel(x),confusionInd);
errind=totalInd;
for i=1:length(confusionInd)
    errind(i,i)=0;
end

errDetail=sum(errind,2)./sum(totalInd,2);% ÿ��Ĵ�����

err = [err; errDetail];
end