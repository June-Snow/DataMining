% main function : main.m
clc; clear all;
number=[1,1,1,1,1,1,1,1,1,1];
phase = 'train';
save_path = strcat('C:\Users\Serissa\Desktop\cifar-10-matlab\', phase);
method = 'bicubic';   % 'bilinear' ,'bicubic','nearest'
for batchi = 1:5
    load(['C:\Users\Serissa\Desktop\cifar-10-matlab\cifar-10-batches-mat\data_batch_',num2str(batchi),'.mat']);
    number = createcifar(save_path, number, data, labels, method);  
end

number=[1,1,1,1,1,1,1,1,1,1];
phase = 'test';
save_path = strcat('C:\Users\Serissa\Desktop\cifar-10-matlab\', phase);
load('C:\Users\Serissa\Desktop\cifar-10-matlab\cifar-10-batches-mat\test_batch.mat');
number = createcifar(save_path, number, data, labels, method);  