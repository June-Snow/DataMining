function ELFSaveRet(model)

%%
%% Save and uninitialize

modelDir = fullfile('./_expData', datestr(now, 30));
olInitDir(modelDir);
save(fullfile(modelDir, 'CNNNet.mat'), '-struct', 'model');
copyfile(iniInfo.iniPath, [modelDir, '/']); 
if ishandle(201), saveas(201, fullfile(modelDir, '201.fig')), end;
if ishandle(202), saveas(202, fullfile(modelDir, '202.fig')), end;
if ishandle(903), saveas(903, fullfile(modelDir, '903.fig')), end;


end