clear;
clc; 
load 'testdata.mat'%�����������ÿ�д���һ������ÿ�д���һ���
PrintTransactions(testdata);%��ӡ������
min_sup = 50;%��ʼ����С֧�ֶ�
min_conf = 0.7;%��ʼ����С���Ŷ�
[rules_left, rules_right] = Apriori(testdata, min_sup, min_conf);%����Apriori�㷨
PrintRules(rules_left, rules_right);%��ӡǿ��������
