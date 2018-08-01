function augImdb = iAugmentData()

%%
targetDirs =  {'D:\STUDY\[1] 图像处理\Database\SURDB0.3\train\过暗异常',};
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
                img = iAugmentImg(img);
            case '.avi'
                try
                    vidObj = VideoReader(filelist{i});
                catch err
                     rethrow(err);
                end
                
                iCutVideo(vidObj, folder, ['AugCut', name], ext);
                iRotateVideo(vidObj, folder, ['AugRot', name], ext);
                % iJitterVideo(filelist{i});
                iFlipudVideo(vidObj, folder, ['AugFli', name], ext);
                iStrechVideo(vidObj, folder, ['AugStr', name], ext);
                iScaleVideo(vidObj, folder, ['AugSca', name], ext);
        end
        disp(filelist{i});
        waitbar(i / length(filelist))
    end
    close(h);
end
end


%%
function iScaleVideo(vidObj, dstfolder, dstname, dstext)
if vidObj.NumberOfFrames < 5
    return
end

H = vidObj.Height;
W = vidObj.Width;
sign = [1 -1];
factor = 1 + sign(randi(2)) * randi(2)/10;

augH = H * factor;
augW = W * factor;
SZ = [augH, augW];

writerObj = VideoWriter(fullfile(dstfolder, [dstname, dstext]));
writerObj.FrameRate = 25;
open(writerObj);

for i = 1 : min(vidObj.NumberOfFrames, 50)
    img = read(vidObj, i);
    augFrame = imresize(img, SZ);
    writeVideo(writerObj, augFrame);
end

close(writerObj);
end


%%
function iStrechVideo(vidObj, dstfolder, dstname, dstext)
if vidObj.NumberOfFrames < 5
    return
end

H = vidObj.Height;
W = vidObj.Width;
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


writerObj = VideoWriter(fullfile(dstfolder, [dstname, dstext]));
writerObj.FrameRate = 25;
open(writerObj);

for i = 1 : min(vidObj.NumberOfFrames, 50)
    img = read(vidObj, i);
    augFrame = imresize(img, SZ);
    writeVideo(writerObj, augFrame);
end

close(writerObj);
end


%%
function iFlipudVideo(vidObj, dstfolder, dstname, dstext)
if vidObj.NumberOfFrames < 5
    return
end

H = vidObj.Height;
W = vidObj.Width;

writerObj = VideoWriter(fullfile(dstfolder, [dstname, dstext]));
writerObj.FrameRate = 25;
open(writerObj);

for i = 1 : min(vidObj.NumberOfFrames, 50)
    img = read(vidObj, i);
    augFrame = flipud(img);
    writeVideo(writerObj, augFrame);
end

close(writerObj);
end


%%
function iCutVideo(vidObj, dstfolder, dstname, dstext)
if vidObj.NumberOfFrames < 20
    return;
end

H = vidObj.Height;
W = vidObj.Width;

writerObj = VideoWriter(fullfile(dstfolder, [dstname, dstext]));
writerObj.FrameRate = 25;
open(writerObj);

startFrame = randi(max(5, vidObj.NumberOfFrames-10), 1);
for i = startFrame : min(vidObj.NumberOfFrames, 50)
    img = read(vidObj, i);
    writeVideo(writerObj, img);
end

close(writerObj);
end


%%
function iRotateVideo(vidObj, dstfolder, dstname, dstext)

if vidObj.NumberOfFrames < 5
    return
end
angleCandidate = [5, 175, 180];

for c = 1 : length(angleCandidate)
    newName = [dstname, 'Angle', num2str(angleCandidate(c))];
    writerObj = VideoWriter(fullfile(dstfolder, [newName, dstext]));
    writerObj.FrameRate = 25;
    open(writerObj);
    
    for i = 1 : min(vidObj.NumberOfFrames, 50)
        img = read(vidObj, i);
        imgAug = imrotate(img, angleCandidate(c));
        writeVideo(writerObj, imgAug);
    end
    close(writerObj);
end

end



%%
function iJitterVideo(vidObj, dstfolder, dstname, dstext)

if vidObj.NumberOfFrames < 5
    return
end

writerObj = VideoWriter(fullfile(dstfolder, [dstname, dstext]));
writerObj.FrameRate = 25;
open(writerObj);

img = read(vidObj, 1);
[J, dm, dn] = olJitter(img);

for i = 1 : min(vidObj.NumberOfFrames, 50)
    img = read(vidObj, i);    
    imgJitter = olJitter(img, 0.01, dm, dn);
    writeVideo(writerObj, imgJitter);
end

close(writerObj);
end