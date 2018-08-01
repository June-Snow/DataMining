function sampleMatPath = opticalflow(opts)

%%
if exist(opts.ofDataPath, 'file')
    sampleMatPath = fullfile(opts.ofDataPath);
    return;
end
run(fullfile(fileparts(mfilename('fullpath')), '../matlab/opticalflow/setup_of.m')) ;

filelist = get_all_files(opts.orignDir, 'ext', '.avi');
filelist = splitlist(filelist, opts.nfold);


%%
for n = 1 : opts.nfold
    filelist_fold = filelist{n};
    nf = length(filelist_fold);
    sampleMat.data = cell(1, nf);
    sampleMat.name = cell(1, nf);
    count = 1;
    for i = 1 : nf % num of videos
        sample = [];
        filename  = filelist_fold{i};
        disp(['Calculating optical flow %s ...\n', filename]);
        aviVideo  = VideoReader(filename);
        videoLen  = aviVideo.NumberOfFrames;
        
        for fNo = 1 : opts.of.sampleLen
            if opts.of.sampleLen>videoLen-opts.of.sampleStep % num of of frames
                warning(fprintf(['file ; %s :sample length(%d) is bigger than '],...
                                ['the length of video minus sample step(%d)\n'],...
                                filename, opts.of.sampleLen, videoLen));
                continue;
            end
            currImg = crop_center(flipud(read(aviVideo, fNo)), 224);
            nextImg = crop_center(flipud(read(aviVideo, fNo+opts.of.sampleStep)), 224);
            uv      = opticalflow_main(currImg, nextImg);
            % orientField = orientComputation(uv(:,:,1), uv(:,:,2), opts.of.blockSigma, opts.of.smoothSigma); %计算方向场
            % diff = double(rgb2gray(imabsdiff(currImg, nextImg)))/255;
            uv = scale_jitter(uv);
            sample = cat(3, sample, uv);
            if opts.of.show
                figure(101);
                subplot(121);imshow(currImg);
                subplot(122);drawingField(uv, 40);
                drawnow();
                pause();
            end
        end
        
        sampleMat.data{count} = sample;
        sampleMat.name{count} = [filelist_fold{i} num2str(i)];
        
        count = count + 1;
    end
    
    try
        save(fullfile(opts.dataDir, ['sampleMat' num2str(n) '.mat']), '-struct','sampleMat');
    catch
        error('save error');
        pause();
    end
end

fprintf('Done optical flow!\n'); 




