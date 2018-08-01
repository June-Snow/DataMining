function opts = iLoadConfigCnn(configPath)

%%
IniInfo = olIni2struct(configPath);
opts = iInitOptsCnn(IniInfo);
