clear;
clc; 
load 'testdatas.mat'%�����������ÿ�д���һ������ÿ�д���һ���
%PrintTransactions(testdatas);%��ӡ������
min_sup = 1;%��ʼ����С֧�ֶ�
min_conf = 0.7;%��ʼ����С���Ŷ�
[rules_left, rules_right] = Apriori(testdatas, min_sup, min_conf);%����Apriori�㷨
PrintRules(rules_left, rules_right);%��ӡǿ��������

% load 'testdatan.mat'%�����������ÿ�д���һ������ÿ�д���һ���
% PrintTransactions(testdatan);%��ӡ������
% min_sup = 1;%��ʼ����С֧�ֶ�
% min_conf = 0.7;%��ʼ����С���Ŷ�
% [rules_left, rules_right] = Apriori(testdatan, min_sup, min_conf);%����Apriori�㷨
% PrintRules(rules_left, rules_right);%��ӡǿ��������