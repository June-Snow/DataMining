load 'test_label';
load 'test_wine';
load 'train_label';
load 'train_wine';


model = svmtrain(train_label, train_wine, '-c 1 -g 0.001 -t 2');
[predict_label1, accuracy1,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.005 -t 2');
[predict_label2, accuracy2,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.01 -t 2');
[predict_label3, accuracy3,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.015 -t 2');
[predict_label4, accuracy4,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.02 -t 2');
[predict_label5, accuracy5,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.025 -t 2');
[predict_label6, accuracy6,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.03 -t 2');
[predict_label7, accuracy7,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.035 -t 2');
[predict_label8, accuracy8,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.04 -t 2');
[predict_label9, accuracy9,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.045 -t 2');
[predict_label10, accuracy10,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 1 -g 0.05 -t 2');
[predict_label11, accuracy11,~] = svmpredict(test_label, test_wine, model);

pro1 = zeros(11, 3);
[pro1(1,1), pro1(1,2)] = missFalseRep(predict_label1);
pro1(1, 3) = accuracy1(1,1)/100;

[pro1(2,1), pro1(2,2)] = missFalseRep(predict_label2);
pro1(2, 3) = accuracy2(1,1)/100;

[pro1(3,1), pro1(3,2)] = missFalseRep(predict_label3);
pro1(3, 3) = accuracy3(1,1)/100;

[pro1(4,1), pro1(4,2)] = missFalseRep(predict_label4);
pro1(4, 3) = accuracy4(1,1)/100;

[pro1(5,1), pro1(5,2)] = missFalseRep(predict_label5);
pro1(5, 3) = accuracy5(1,1)/100;

[pro1(6,1), pro1(6,2)] = missFalseRep(predict_label6);
pro1(6, 3) = accuracy6(1,1)/100;

[pro1(7,1), pro1(7,2)] = missFalseRep(predict_label7);
pro1(7, 3) = accuracy7(1,1)/100;

[pro1(8,1), pro1(8,2)] = missFalseRep(predict_label8);
pro1(8, 3) = accuracy8(1,1)/100;

[pro1(9,1), pro1(9,2)] = missFalseRep(predict_label9);
pro1(9, 3) = accuracy9(1,1)/100;

[pro1(10,1), pro1(10,2)] = missFalseRep(predict_label10);
pro1(10, 3) = accuracy10(1,1)/100;

[pro1(11,1), pro1(11,2)] = missFalseRep(predict_label11);
pro1(11, 3) = accuracy11(1,1)/100;

x1 = [0.001,0.005,0.01,0.015,0.02,0.025,0.03,0.035,0.04,0.045,0.05];
[m, I1]= max(pro1(:, 3));
subplot(131);
plot(x1, pro1);
hleg = legend('漏报率','误报率', '准确率');
ylabel('ratio');
xlabel('g');

text(x1(1,I1), pro1(I1, 3), ['\leftarrow T = ', num2str(pro1(I1, 3))]);
title('t = 2, c = 1');

model = svmtrain(train_label, train_wine, '-c 2 -g 0.001 -t 2');
[predict_label1, accuracy1,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.005 -t 2');
[predict_label2, accuracy2,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.01 -t 2');
[predict_label3, accuracy3,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.015 -t 2');
[predict_label4, accuracy4,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.02 -t 2');
[predict_label5, accuracy5,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.025 -t 2');
[predict_label6, accuracy6,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.03 -t 2');
[predict_label7, accuracy7,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.035 -t 2');
[predict_label8, accuracy8,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.04 -t 2');
[predict_label9, accuracy9,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.045 -t 2');
[predict_label10, accuracy10,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 2 -g 0.05 -t 2');
[predict_label11, accuracy11,~] = svmpredict(test_label, test_wine, model);

pro = zeros(11, 3);
[pro(1,1), pro(1,2)] = missFalseRep(predict_label1);
pro(1, 3) = accuracy1(1,1)/100;

[pro(2,1), pro(2,2)] = missFalseRep(predict_label2);
pro(2, 3) = accuracy2(1,1)/100;

[pro(3,1), pro(3,2)] = missFalseRep(predict_label3);
pro(3, 3) = accuracy3(1,1)/100;

[pro(4,1), pro(4,2)] = missFalseRep(predict_label4);
pro(4, 3) = accuracy4(1,1)/100;

[pro(5,1), pro(5,2)] = missFalseRep(predict_label5);
pro(5, 3) = accuracy5(1,1)/100;

[pro(6,1), pro(6,2)] = missFalseRep(predict_label6);
pro(6, 3) = accuracy6(1,1)/100;

[pro(7,1), pro(7,2)] = missFalseRep(predict_label7);
pro(7, 3) = accuracy7(1,1)/100;

[pro(8,1), pro(8,2)] = missFalseRep(predict_label8);
pro(8, 3) = accuracy8(1,1)/100;

[pro(9,1), pro(9,2)] = missFalseRep(predict_label9);
pro(9, 3) = accuracy9(1,1)/100;

[pro(10,1), pro(10,2)] = missFalseRep(predict_label10);
pro(10, 3) = accuracy10(1,1)/100;

[pro(11,1), pro(11,2)] = missFalseRep(predict_label11);
pro(11, 3) = accuracy11(1,1)/100;

x = [0.001,0.005,0.01,0.015,0.02,0.025,0.03,0.035,0.04,0.045,0.05];
[m, I]= max(pro(:, 3));
subplot(132);
plot(x, pro);
hleg = legend('漏报率','误报率', '准确率');
ylabel('ratio');
xlabel('g');

text(x(1,I), pro(I, 3), ['\leftarrow T = ', num2str(pro(I, 3))]);
title('t = 2, c = 2');

model = svmtrain(train_label, train_wine, '-c 3 -g 0.001 -t 2');
[predict_label1, accuracy1,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.005 -t 2');
[predict_label2, accuracy2,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.01 -t 2');
[predict_label3, accuracy3,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.015 -t 2');
[predict_label4, accuracy4,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.02 -t 2');
[predict_label5, accuracy5,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.025 -t 2');
[predict_label6, accuracy6,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.03 -t 2');
[predict_label7, accuracy7,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.035 -t 2');
[predict_label8, accuracy8,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.04 -t 2');
[predict_label9, accuracy9,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.045 -t 2');
[predict_label10, accuracy10,~] = svmpredict(test_label, test_wine, model);

model = svmtrain(train_label, train_wine, '-c 3 -g 0.05 -t 2');
[predict_label11, accuracy11,~] = svmpredict(test_label, test_wine, model);

pro = zeros(11, 3);
[pro(1,1), pro(1,2)] = missFalseRep(predict_label1);
pro(1, 3) = accuracy1(1,1)/100;

[pro(2,1), pro(2,2)] = missFalseRep(predict_label2);
pro(2, 3) = accuracy2(1,1)/100;

[pro(3,1), pro(3,2)] = missFalseRep(predict_label3);
pro(3, 3) = accuracy3(1,1)/100;

[pro(4,1), pro(4,2)] = missFalseRep(predict_label4);
pro(4, 3) = accuracy4(1,1)/100;

[pro(5,1), pro(5,2)] = missFalseRep(predict_label5);
pro(5, 3) = accuracy5(1,1)/100;

[pro(6,1), pro(6,2)] = missFalseRep(predict_label6);
pro(6, 3) = accuracy6(1,1)/100;

[pro(7,1), pro(7,2)] = missFalseRep(predict_label7);
pro(7, 3) = accuracy7(1,1)/100;

[pro(8,1), pro(8,2)] = missFalseRep(predict_label8);
pro(8, 3) = accuracy8(1,1)/100;

[pro(9,1), pro(9,2)] = missFalseRep(predict_label9);
pro(9, 3) = accuracy9(1,1)/100;

[pro(10,1), pro(10,2)] = missFalseRep(predict_label10);
pro(10, 3) = accuracy10(1,1)/100;

[pro(11,1), pro(11,2)] = missFalseRep(predict_label11);
pro(11, 3) = accuracy11(1,1)/100;

x = [0.001,0.005,0.01,0.015,0.02,0.025,0.03,0.035,0.04,0.045,0.05];
[m, I]= max(pro(:, 3));
subplot(133);
plot(x, pro);
hleg = legend('漏报率','误报率', '准确率');
ylabel('ratio');
xlabel('g');

text(x(1,I), pro(I, 3), ['\leftarrow T = ', num2str(pro(I, 3))]);
title('t = 2, c = 3');




