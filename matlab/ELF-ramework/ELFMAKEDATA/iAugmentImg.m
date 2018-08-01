function augImdb = iAugmentImg()

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
        iRotateImg(img, folder, ['augrot', name], ext);
        iJitterImg(img, folder, ['augjit', name], ext);
        iFlipudImg(img, folder, ['augfli', name], ext);
        iStrechImg(img, folder, ['augstr', name], ext);
        iScaleImg(img, folder, ['augsca', name], ext);
        disp(filelist{i});
        waitbar(i / length(filelist))
    end
    close(h);
end
end


%%
function augImg = iScaleImg(img, dstfolder, dstname, dstext)
[H, W, ~] = size(img);
sign = [1 -1];
factor = 1 + sign(randi(2)) * randi(2)/10;

augH = H * factor;
augW = W * factor;
SZ = [augH, augW];
augImg = imresize(img, SZ);

if nargout == 0
    imwrite(augImg, fullfile(dstfolder, [dstname, dstext]));
end
end


%%
function augImg = iStrechImg(img, dstfolder, dstname, dstext)
[H, W, ~] = size(img);
sign = [1 -1];
factor = 1 + sign(randi(2)) * randi(2)/10;
augH = H;
augW = W;
if sign(randi(2)) > 0
    augH = H * factor;
else
    augW = W * factor;
end
SZ = [augH, augW];

augImg = imresize(img, SZ);
if nargout == 0
    imwrite(augImg, fullfile(dstfolder, [dstname, dstext]));
end

end


%%
function augImg = iFlipudImg(img, dstfolder, dstname, dstext)
augImg = flipud(img);

if nargout == 0
    imwrite(augImg, fullfile(dstfolder, [dstname, dstext]));
end
end


%%
function augImg = iRotateImg(img, dstfolder, dstname, dstext)

angleCandidate = [2, 178, 180];
[M, N, C] = size(img);
for c = 1 : length(angleCandidate)
    newName = [dstname, 'Angle', num2str(angleCandidate(c))];
    
    augImg = imrotate(img, angleCandidate(c));
    if nargout == 0
        display([newName, dstext]);
        augImg = imcrop(augImg, [M*0.1 N *0.1, M*0.8 N*0.8]);
        imwrite(augImg, fullfile(dstfolder, [newName, dstext]));
    end
end

end



%%
function augImg = iJitterImg(img, dstfolder, dstname, dstext)

[J, dm, dn] = olJitter(img);
augImg = olJitter(img, 0.01, dm, dn);
imwrite(augImg, fullfile(dstfolder, [dstname, dstext]));
end