clear all
clc

%% 以字符的形式读取txt
fid = fopen('H:\leaf-cnn\classification\deeplearning\leafOcclusion\data\test.proto', 'r');
k = 1;
data = cell(2158, 2);
while ~feof(fid)
    tline = fgetl(fid);
    if ~isempty(tline)
        data(k, 1) = mat2cell(tline);
        tline = fgetl(fid);
        data(k, 2) = mat2cell(tline);
        k = k + 1;
    end
   
end
xlswrite('H:\leaf-cnn\classification\deeplearning\leafOcclusion\data\test.xlsx', data);
fclose(fid);
%% 

path = 'H:\leaf-cnn\classification\deeplearning\leafRecognition\caffeModel\SelectionModel\';
excelPath = strcat(path, 'test.xlsx');
if exist(excelPath, 'file')
    [strData, strName] = xlsread(excelPath);
    [strName, index] = sortrows(strName);
    strData = strData(index);
end
fileStr = 'alexnet_train201612261010_iter_';
var = zeros(5, 1);
err = zeros(5, 1);


%for i = 400: 400: 2000
    %excelPath = strcat(path, fileStr, num2str(i), 'predict_result.csv');
    excelPath = strcat(path, 'leaf&normal_2000predict_result.csv');
    [strData1, strName1] = xlsread(excelPath);
    strData1 = strData1(:, 3);
    [strName1, index] = sortrows(strName1);
    strData1 = strData1(index);
 
    err11 = sum((strData1-strData)<-0.5);
    err12 = sum((strData1-strData)>0.5);
 
    excelPath = strcat(path, 'leaf&normal_blackleaf_800predict_result.csv');
    [strData1, strName1] = xlsread(excelPath);
    strData1 = strData1(:, 3);
    [strName1, index] = sortrows(strName1);
    strData1 = strData1(index);
 
    err21 = sum((strData1-strData)<-0.5);
    err22 = sum((strData1-strData)>0.5);
    
        excelPath = strcat(path, 'leaf&normal_normalgree_800predict_result.csv');
    [strData1, strName1] = xlsread(excelPath);
    strData1 = strData1(:, 3);
    [strName1, index] = sortrows(strName1);
    strData1 = strData1(index);
 
    err31 = sum((strData1-strData)<-0.5);
    err32 = sum((strData1-strData)>0.5);
    
        excelPath = strcat(path, 'leaf&normal_normalgree_blackleaf_1600predict_result.csv');
    [strData1, strName1] = xlsread(excelPath);
    strData1 = strData1(:, 3);
    [strName1, index] = sortrows(strName1);
    strData1 = strData1(index);
 
    err41 = sum((strData1-strData)<-0.5);
    err42 = sum((strData1-strData)>0.5);
    
        excelPath = strcat(path, 'leaf_blackleaf&normal_800predict_result.csv');
    [strData1, strName1] = xlsread(excelPath);
    strData1 = strData1(:, 3);
    [strName1, index] = sortrows(strName1);
    strData1 = strData1(index);
 
    err51 = sum((strData1-strData)<-0.5);
    err52 = sum((strData1-strData)>0.5);
    
        excelPath = strcat(path, 'leaf_blackleaf&normal_normalgree_2000predict_result.csv');
    [strData1, strName1] = xlsread(excelPath);
    strData1 = strData1(:, 3);
    [strName1, index] = sortrows(strName1);
    strData1 = strData1(index);
 
    err61 = sum((strData1-strData)<-0.5);
    err62 = sum((strData1-strData)>0.5);
    
        excelPath = strcat(path, 'leaf_normalgree&normal_2000predict_result.csv');
    [strData1, strName1] = xlsread(excelPath);
    strData1 = strData1(:, 3);
    [strName1, index] = sortrows(strName1);
    strData1 = strData1(index);
 
    err71 = sum((strData1-strData)<-0.5);
    err72 = sum((strData1-strData)>0.5);
    
    
            excelPath = strcat(path, 'leaf_normalgree&normal_blackleaf_2000predict_result.csv');
    [strData1, strName1] = xlsread(excelPath);
    strData1 = strData1(:, 3);
    [strName1, index] = sortrows(strName1);
    strData1 = strData1(index);
 
    err81 = sum((strData1-strData)<-0.5);
    err82 = sum((strData1-strData)>0.5);
    
            excelPath = strcat(path, 'leaf_normalgree_blackleaf&normal_800predict_result.csv');
    [strData1, strName1] = xlsread(excelPath);
    strData1 = strData1(:, 3);
    [strName1, index] = sortrows(strName1);
    strData1 = strData1(index);
 
    err91 = sum((strData1-strData)<-0.5);
    err92 = sum((strData1-strData)>0.5);
%end







