% clc
% clear 
[label, data] = libsvmread('D:\STUDY\[0] ELF-ramework\ELF-ramework\ELF-ramework\_expData/20150606T150423/blkStat.txt');

[bestacc,bestc,bestg] = SVMcgForClass(label, data, -10,10,-10,10,5,0.5,0.5,4.5);
cmd = sprintf('-c %f -g %f', bestc, bestg)
model = svmtrain(label, data, cmd);
% model = svmtrain(label, data, '-t 2');
fprintf('Done train\n\n\n\n\n');
[predlabel, preddata] = libsvmread('D:\STUDY\[0] ELF-ramework\ELF-ramework\ELF-ramework\_expData/20150606T140216/blkStat.txt');
[outLabel, acc] = svmpredict(predlabel, preddata, model);