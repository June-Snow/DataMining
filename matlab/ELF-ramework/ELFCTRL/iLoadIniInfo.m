function iniInfo = iLoadIniInfo(iniPath)

%% 初始化赋值iniInfo
iniStruct = olIni2struct(iniPath);%读取配置文件
iniInfo = iIni2info(iniStruct);%通过iniStruct初始化赋值iniInfo

