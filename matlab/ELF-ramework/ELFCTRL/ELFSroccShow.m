function [] = ELFSroccShow(h, label, pred, errRecord, numEpoch)

%% 显示训练结果，正确与错误分类对比、正确率、错误率
figure(h);
set(h, 'Name', 'Monitor')
set(gcf,'color','w');

startID = 1;
endID =length(label);
%%
subplot(211) ;
cla;
if endID > 1 
    plotStart = startID;%dataInd(1);
    plotEnd = endID;%dataInd(numSample);
    plot(plotStart:plotEnd, label, '*', 'color', [0 1 0] );hold on;
    errSample = (label~=pred).*pred;
    plot(plotStart:plotEnd, errSample, '.','MarkerSize',20, 'color', [1 0 0] );hold on;
    legend('Input Label',  'Output Label') ;
    xlabel('Data Index');
    ylabel('Label');
    title(strcat('Regression Detail:', num2str(1-errRecord(end))));
    grid on
end

%% 
subplot(212) ;
cla;
errRecord = 1 - errRecord;
opt = 1:10;
xlim = numEpoch*opt;
maxXInd = find(xlim>length(errRecord), 1, 'first');
plot(1:size(errRecord, 2), errRecord(1, :), 'r-x','linewidth', 2) ; hold on ;
set(gca,'YLim',[0 1.01]);
set(gca,'XLim',[0 xlim(maxXInd)]);
xlabel('Epoch') ; ylabel('Srocc rate') ;
title('Srocc') ;
grid on ;

drawnow;

end

