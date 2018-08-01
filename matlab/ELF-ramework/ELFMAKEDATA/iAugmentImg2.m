function iAugmentImg2()

%%
targetDirs =  {'D:\STUDY\[1] 图像处理\Database\SURDB0.2.1\pics\crops' ...
    'D:\STUDY\[1] 图像处理\Database\SURDB0.2.1\pics\crops\colorcast',...
    'D:\STUDY\[1] 图像处理\Database\SURDB0.2.1\pics\crops\dark'};
% 'D:\STUDY\[1] 图像处理\Database\SURDB\train\偏色异常'};


%%
for p = 1 : length(targetDirs)
    targetDir = targetDirs{p};
    h = waitbar(0, 'Augmenting Feature...');
    filelist = olGetAllFile(targetDir);
    for i = 1 : length(filelist)
        [folder, name, ext] = fileparts(filelist{i});
        switch olStdExt(ext)
            case '.bmp'
                img = imread(filelist{i});   
            case '.avi'
                try
                    vidObj = VideoReader(filelist{i});
                catch err
                     rethrow(err);
                end
            otherwise
             continue;
        end
        iSplitImg(img, folder, ['augsplit', name], ext);
        disp(filelist{i});
        waitbar(i / length(filelist))
    end
    close(h);
end
end


%%
function iSplitImg(img, dstfolder, dstname, dstext)
    [M, N, ~] = size(img);
    if M >400 && N>400
        img1 = img(1:200, 1:200, :);
        imwrite(img1, fullfile(dstfolder, [dstname, '1', dstext]));
        img2 = img(M-200+1:M, N-200+1:N, :);
        imwrite(img2, fullfile(dstfolder, [dstname, '2', dstext]));
        img3 = img(M-200+1:M, 1:200, :);
        imwrite(img3, fullfile(dstfolder, [dstname, '3', dstext]));
        img4 = img(1:200, N-200+1:N, :);
        imwrite(img4, fullfile(dstfolder, [dstname, '4', dstext]));
    end
end

