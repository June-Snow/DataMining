function iniInfo = iLoadIniInfo(iniPath)

%% ��ʼ����ֵiniInfo
iniStruct = olIni2struct(iniPath);%��ȡ�����ļ�
iniInfo = iIni2info(iniStruct);%ͨ��iniStruct��ʼ����ֵiniInfo

