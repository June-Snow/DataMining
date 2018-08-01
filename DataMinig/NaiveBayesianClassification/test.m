clear all;
clc;

N=10000;
L=100;
time=100;
map=0;

for i=1:time
    data=rand(N,L);
    data=data-0.5;
    label=(rand(N,1)>0.5);

    train_data=data(1:50,:);
    train_label(1:50)=label(1:50);
    [pxj,pj]=nbc_train(train_data,train_label);

    test_data=data(51:100,:);
    test_label=label(51:100);
    [predict_label,p]=nbv_predict(test_data,pxj,pj);

    predict_label=(predict_label-1)';
    ap=sum((predict_label-test_label)==0)/length(test_label);
    map=map+ap;
    i
disp('          Classfication completed               ');
end

map=map/time;