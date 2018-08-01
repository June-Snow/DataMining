function [] = ELFShow(h, label, pred, nClass, className, errRecord, numEpoch, startID, endID)

%% 显示训练结果，正确与错误分类对比、正确率、错误率
figure(h);
set(h, 'Name', 'Monitor')
set(gcf,'color','w');

%% Prepare Data
if nargin < 4
    return
end
if ~exist('className', 'var')
    className = arrayfun(@(x) x, 1:nClass, 'UniformOutput', false);
end

if ~exist('errRecord', 'var')
    errRecord = 0;
end

if ~exist('startID', 'var') || ~exist('endID', 'var')
    startID = 1;
    endID =length(label); 
end

numClass= nClass;
numSample = length(label);
label01 = olCvt01Matrix(label, [numClass, numSample]);
pred01 = olCvt01Matrix(pred, [numClass, numSample]);
[err, confusionMatrix, confusionInd, rates] = confusion(label01, pred01);


%%
subplot(211);
cla;
if numClass > 1 && numSample >1
    plotStart = startID;%dataInd(1);
    plotEnd = endID;%dataInd(numSample);
    plot(plotStart:plotEnd, label, '*', 'color', [0 1 0] );hold on;
    errSample = (label~=pred).*pred;
    plot(plotStart:plotEnd, errSample, '.','MarkerSize',20, 'color', [1 0 0] );hold on;
    legend('Input Label',  'False Label') ;
    set(gca, 'XLim',[plotStart plotEnd], 'YLim',[1 numClass]); % +1 in case bad property
    set(gca, 'Xtick', [plotStart : ceil(numSample/10) : plotEnd], 'Ytick', [1 : 1 : numClass]);
    xlabel('Data Index');
    ylabel('Label');
    title('Classification Detail');
    grid on
end


%% 
subplot(223) ;
cla;
if size(errRecord, 2) == 1       
    h = barh(flipud(errRecord)); 
    %set(gca,'XLim',[0 1]);
    colormap summer;
    set(gca,'YTickLabel',fliplr([{'Error'} className]), 'XLim',[0 1.1]);
    olFreezeColors;
else
    opt = 1:10;
    xlim = (numEpoch+1)*opt;
    maxXInd = find(xlim>length(errRecord), 1, 'first');
    for i = 1 : 1 + numClass % +1 for show total err
        if i == 1
            plot(1:size(errRecord, 2), errRecord(i, :), 'r-x','linewidth', 2) ; hold on ;
        else
            style = olChooseStyle(i);
            plot(1:size(errRecord, 2), errRecord(i, :), style{:}) ; hold on ;
        end
    end
    set(gca,'YLim',[0 1.01]);
    set(gca,'XLim',[0 xlim(maxXInd)]);
    xlabel('Epoch') ; ylabel('Error rate') ;
    legend ([{'Error rate'}, arrayfun(@(x) [num2str(x) ' : ' className{x}], 1:length(className), 'UniformOutput', false)]) ;
end

title('Error') ;
grid on ;


%%
subplot(224);
olPlotCmatrix(1:numClass, confusionMatrix);
title('Confusion Matrix');
ylabel('Input Label');
xlabel('Output Label');

drawnow;

end

