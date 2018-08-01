function  [model] = ELFPipeLinePredict(rawImdb, iniInfo, model, type, trainType)
%视频路径\\WIN-T59N5QCJB4Q\video
%% Declare
clc;
% SAVE = 1;
% nClass = length(model.class);
% sep = iniInfo.data.sep;
% 
% retDir = fullfile('./_expData', datestr(now, 30));
% retPath = fullfile(retDir, 'data.txt');
% statPath = fullfile(retDir, 'tabulate_pred.txt');
% accPath = fullfile(retDir, 'acc.txt');
% blkStatPath = fullfile(retDir, 'blkStat.txt');
% 
% fid = -1;
% fidblkstat = -1;

%% Predict
% label = rawImdb.label;
% dim = iQueryFeatDim(iniInfo.train.method); 
 h = waitbar(0,'Predicting...');
% count = 1;
savePath = 'E:\leaf\';
path = '\\WIN-T59N5QCJB4Q\video\';%\\WIN-T59N5QCJB4Q\video
excelPath = 'C:\Users\Serissa\Desktop\正常视频.xlsx';
[imgName, files] = xlsread(excelPath);
len = length(files);

dim = 2;
sep = 3;


for i = 39420 : len%length(rawImdb.relPath)
    count = 0;
    tic
    rawInstancePath = strcat(path, files{i,2}, '\', files{i,1});%fullfile(rawImdb.rawDataDir, rawImdb.relPath(i));
  
    if exist(rawInstancePath, 'file')
        try
            video = VideoReader(rawInstancePath);
            image = read(video, 1);
        catch err
            continue;
        end
    else
        continue;
    end

    [~, name, ~] = fileparts(rawInstancePath);
    [featImdb] = ELFExtractFeature(model.featName, rawInstancePath, dim, type);    
    featImdb = iSepFeatImdb(featImdb, sep);
    featImdb.feature = iRescale(featImdb.feature, size(model.meanV));
    featImdb.feature = iNormarlizeData(featImdb.feature, model.meanV, model.stdV);
    
    for j = 1 : length(featImdb.feature)
        feature = iGetBatch(featImdb.feature, [], j) ;
        [pred_(j), prop_(j)] = ELFCnnPredict(model, feature, trainType);
        % predprop2(i) = iPostPredictProp(prop);
        if pred_(j) == 1
            count = count + 1;

        end
    end
    if count ~= 0
        retDir = strcat(savePath, num2str(count), '\');
        olInitDir(retDir);
        imwrite(image, strcat(retDir, name, '.jpg'));
    end
    waitbar(i / len);%length(rawImdb.relPath));
    
%     toc
%     labelPic(fullfile(rawInstancePath), pred_, model.class, sep);
%     pred(i) = iPostPredictPred(pred_);
%     degree = iPostPredictDegree(prop_, 1:length(model.class));
%     axis off
%     %pause;%暂停
%     
%     fprintf('label: %d\n', pred(i));
%     
%     
%     % Save
%     stat = tabulate(pred);
%     if SAVE == 1
%         olInitDir(retDir);
%         
%         ss=rawImdb.relPath(i);
%         sss = regexp(ss{1,1}, '/', 'split');
%         pathh = strcat(retDir, sss{1,1});
%         olInitDir(pathh);
%         ssss = sss{1,2};
%         pathh = strcat(pathh, '\',ssss);
%         frame = getframe(gcf);
%         image = frame2im(frame);
%         imwrite(image, pathh);
%         if fid == -1
%             fid = fopen(retPath, 'w');
%         end
%        
%         if fidblkstat == -1
%             fidblkstat = fopen(blkStatPath, 'w');
%         end
%         
%         fprintf(fid, '%d %d ', label(i), pred(i));
%         for k = 1 : length(degree)
%              fprintf(fid, '%f ', degree(k)); 
%         end
%         fprintf(fid, '%s \n', rawImdb.relPath{i});
%         
%         fprintf(fidblkstat, '%d ', label(i));
%         for j = 1 : length(pred_)
%             fprintf(fidblkstat, '%d:%d ', j, pred_(j));
%         end
%         fprintf(fidblkstat, '\n');
%         
%         stat = tabulate(pred);       
%         tabPred = array2table(stat, 'VariableNames',{'Class' 'Count' 'Percent'});
%         writetable(tabPred, statPath, 'delimiter', '\t');
%     else
%         disp(stat);
%     end
%     disp(rawImdb.relPath(i));
%     
%     %创建相关文件
%     if i+1 < length(rawImdb.relPath)
%         ss1=rawImdb.relPath(i);
%         ss2=rawImdb.relPath(i+1);
%         index = find(ss1{1,1} == '/');
%         if strncmp(ss1{1,1}, ss2{1,1}, index) == 0
%             retDir = fullfile('./_expData', datestr(now, 30));
%             retPath = fullfile(retDir, 'data.txt');
%             statPath = fullfile(retDir, 'tabulate_pred.txt');
%             accPath = fullfile(retDir, 'acc.txt');
%             blkStatPath = fullfile(retDir, 'blkStat.txt');
%             if SAVE == 1
%                 fclose(fid);
%                 fclose(fidblkstat);
%                 olInitDir(retDir);               
%                 fid = fopen(retPath, 'w');
%                 fidblkstat = fopen(blkStatPath, 'w');
%                 h = figure(203);
%                 
%                 ELFShow(h, label(count:i), pred(count:i), nClass);
%                 if ishandle(203), saveas(203, fullfile(retDir, '202.fig')), end;
%                 count = i+1;
%             end
%         end
%     end
    
end
% ELFShow(h, label(count:length(rawImdb.relPath)), pred(count:length(rawImdb.relPath)), nClass);
% if ishandle(203), saveas(203, fullfile(retDir, '202.fig')), end;
 close(h);
% 
% 
% if SAVE == 1
%     fidacc = fopen(accPath, 'w');
%     fprintf(fid, '%s\n', rawImdb.rawDataDir);  ACC = sum((label == pred))/length(label);
%     fprintf(fidacc,'ACC: %f\n', ACC);   
%     fclose(fid);
%     fclose(fidacc);
%     fclose(fidblkstat);
%     h = figure(203);
%     ELFShow(h, label, pred, nClass);
%     if ishandle(203), saveas(203, fullfile(retDir, '202.fig')), end;
% end

iUnInitialize(iniInfo);
end


