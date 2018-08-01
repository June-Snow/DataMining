function [c,cm,ind,per] = olConfusionMatrix(label, pred)

%%
label01 = full(sparse(label, 1:length(label), 1));
pred01 = full(sparse(pred, 1:length(pred), 1));
[c,cm,ind,per] = confusion(label01, pred01);
end