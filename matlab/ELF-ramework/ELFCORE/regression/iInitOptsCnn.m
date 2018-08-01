function opts =  iInitOptsCnn(IniInfo)

%%
opts.algo = IniInfo.algo;
opts.useGpu = str2double(IniInfo.usegpu);
opts.batchSize = str2double(IniInfo.batchsize);
opts.modelPath = IniInfo.cnn.modelpath;