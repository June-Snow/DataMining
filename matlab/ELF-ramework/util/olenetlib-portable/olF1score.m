function [f1score, f1sep] = olF1score(label, pred)

%%
[~, cm, ~,~] = olConfusionMatrix(label, pred);
[K, ~] = size(cm);
for i = 1 : K
    prec = cm(i,i)/sum(cm(:, i));
    recl = cm(i,i)/sum(cm(i, :));
    f1(i) = ((prec*recl)*2) / (prec+recl); 
end

f1score = mean(f1);
f1sep = f1;
end