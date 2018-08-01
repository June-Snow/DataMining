function [rawImdb] = ELFMakeData(iniInfo, trainType)

%%
rawImdb = iGetRawimdb(iniInfo.rawDataDir, iniInfo.targetfolder, iniInfo.typeFilter, trainType);
% rawImdb = iSepDatarawImdb, iniInfo.data.sep);

end