function pred2 = iPostPredictPred(pred)

%%
MaxFreq = 1;
CenterSensitive = 2;
OPTION = CenterSensitive;
leaf = 2;

%% ͼƬԤ�����ͼ�Ϊ��������������
% CenterSensitive
l = length(pred);
predS = reshape(pred, sqrt(l), sqrt(l));

if sum(sum(leaf == predS(ceil(sqrt(l)/3):ceil(sqrt(l)*2/3), ceil(sqrt(l)/3):ceil(sqrt(l)*2/3)))) >= 3
    pred2 = leaf;
    return 
end

% case MaxFreq
pred = blockproc(predS', [ceil(sqrt(l)/3), ceil(sqrt(l)/3)], @(x) maxFreq(x.data(:)) );
pred2 = maxFreq(pred);

%% TODO�����Bayesian������ʺ���

end
 