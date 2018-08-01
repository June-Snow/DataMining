%wine_SVM script by faruto 2009.8.12
%Email:farutoliyang@gmail.com QQ:516667408 blog:http://sina.com.cn/faruto
%www.ilovematlab.cn

load wine_SVM;

data = [wine(:,1), wine(:,2)];

groups = ismember(wine_labels,1); % 1不变其余设为0

[train, test] = crossvalind('holdOut',groups); % 178个样本，区分出训练集88个，测试集90
%train and test here are logical format

train_wine = data(train,:);
train_wine_labels = groups(train,:);
train_wine_labels = double( train_wine_labels );
%in the usage of libsvm, the label vector and instance matrix must be
%double. So we have to transfer the format of labels in this case.

test_wine = data(test,:);
test_wine_labels = groups(test,:);
test_wine_labels = double( test_wine_labels );

% train_wine = normalization(train_wine',2);
% test_wine = normalization(test_wine',2);
% train_wine = train_wine';
% test_wine = test_wine';


% bestcv = 0;
% for log2c = -5:5,
%   for log2g = -5:5,
%     cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
%     cv = svmtrain(train_wine_labels, train_wine, cmd);
%     if (cv >= bestcv),
%       bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
%     end
%   end
% end
% fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
% cmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg)];
% model = svmtrain(train_wine_labels, train_wine, cmd);




model = svmtrain(train_wine_labels, train_wine, '-c 1 -g 0.07');

[predict_label, accuracy] = svmpredict(test_wine_labels, test_wine, model);

%plot visualization for train_wine
% w = model.SVs' * model.sv_coef;
% b = -model.rho;
[mm,mn] = size(model.SVs);

figure;
hold on;
[m,n] = size(train_wine);%训练数据矩阵，M为训练数据的个数
for run = 1:m
    if train_wine_labels(run) == 1    %如果训练数据被划分为第一类
        h1 = plot( train_wine(run,1),train_wine(run,2),'r+' );%利用wine每个数据的两个特征值来标识它在矩阵中的点的位置，并绘以颜色
    else
        h2 = plot( train_wine(run,1),train_wine(run,2),'g*' );
    end
    for i = 1:mm
        if model.SVs(i,1)==train_wine(run,1) && model.SVs(i,2)==train_wine(run,2)%如果该点是相关向量机的话，用O标识
            h3 = plot( train_wine(run,1),train_wine(run,2),'o' );
        end
    end
end
% legend([h1,h2,h3],'1','0','Support Vectors');
% hold off;







load wine_SVM;

train_wine = [wine(1:30,:);wine(60:95,:);wine(131:153,:)];
train_wine_labels = [wine_labels(1:30);wine_labels(60:95);wine_labels(131:153)];

test_wine = [wine(31:59,:);wine(96:130,:);wine(154:178,:)];
test_wine_labels = [wine_labels(31:59);wine_labels(96:130);wine_labels(154:178)];

[train_wine,pstrain] = mapminmax(train_wine');%逗号什么意思？矩阵转置
%mapminmax函数对矩阵的每一行进行归一，故归一前先进行矩阵转置
pstrain.ymin = 0;        %原先归一到-1到1，现在变成0到1
pstrain.ymax = 1;
[train_wine,pstrain] = mapminmax(train_wine,pstrain);

[test_wine,pstest] = mapminmax(test_wine');
pstest.ymin = 0;
pstest.ymax = 1;
[test_wine,pstest] = mapminmax(test_wine,pstest);

train_wine = train_wine';%重新转置回来
test_wine = test_wine';

%[bestacc,bestc,bestg] = SVMcg(train_wine_labels,train_wine,-2,4,-4,4,3,0.5,0.5,0.9);%调用构造的的SVMcg函数
[bestacc,bestc,bestg] = SVMcgForClass(train_wine_labels,train_wine,-2,4,-4,4,3,0.5,0.5,0.9);%调用自己构造的的SVMcgForClass函数，MATLAB包中没有

%[bestacc,bestc,bestg]=SVMcgForRegress(train_wine_labels,train_wine,-1,1,2,2,3,0.1,0.1,0.1);%调用自己构造的的SVMcgForRegress函数，MATLAB包中没有

cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
model = svmtrain(train_wine_labels,train_wine,cmd);
%[pre,acc] = svmpredict(test_wine_labels,test_wine,model);
[predict_label, accuracy, ~] = svmpredict(test_wine_labels, test_wine, model);
accuracy
