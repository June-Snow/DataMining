function iniInfo =  iIni2info(iniStruct)
%��iniStruct�е����ݸ�ֵ��iniInfo
%%
iniInfo.data.sep = str2double(iniStruct.data.sep);
iniInfo.data.mode = iniStruct.data.mode;

iniInfo.rawDataDir = iniStruct.data.rawdatadir;
iniInfo.typeFilter =  iniStruct.data.rawdataext;
iniInfo.targetfolder = olStr2cell(iniStruct.data.targetfolder);

iniInfo.train.numEpoch = str2double(iniStruct.train.numepoch);
iniInfo.train.method = iniStruct.train.method;
iniInfo.iniPath = iniStruct.ini.path;

iniInfo.program.debug = str2double(iniStruct.program.debug);