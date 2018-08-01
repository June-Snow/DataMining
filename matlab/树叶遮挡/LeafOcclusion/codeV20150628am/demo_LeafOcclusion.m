set_startup;

%%
FILEEXT  = '*.avi';
START    = 1;
Mrow     = 288;
Mcol     = 352;
FrameLen = 20;
Tol = 10;%ÏñËØ·ù¶ÈÈÝ²î
Thr = 0.1;%ÀÛ»ýÖ¡²î¸ÅÂÊ
xNum = 5;%·Ö¿é
yNum = 5;
TraRate = 0.8;

%%
FILEDIR  = '..\data\leafPicture\';
Label = 1;
[train_s, train_s_label, test_s, test_s_label] = dataSet(START, FILEDIR, FILEEXT, ...
Mrow, Mcol,FrameLen,Tol,Thr,xNum,yNum, TraRate, Label);

FILEDIR  = '..\data\normalPicture\';
Label = -1;
[train_n, train_n_label, test_n, test_n_label] = dataSet(START, FILEDIR, FILEEXT, ...
Mrow, Mcol,FrameLen,Tol,Thr,xNum,yNum, TraRate, Label);

[train_set, train_label] = trainTestSet(train_s, train_n, train_s_label, train_n_label);
[test_set, test_label] = trainTestSet(test_s, test_n, test_s_label, test_n_label);

train_wine = normalization(train_set,2);
test_wine = normalization(test_set,2);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.05 -t 2');
[predict_label11, accuracy11,~] = svmpredict(test_label, test_wine, model);





