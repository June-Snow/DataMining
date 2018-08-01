
clear all;
clc;


filePath = 'H:\正常视频b...典型正常';
savePath = 'E:\bmp';

StartPos = 1;

fileType = '*.avi';
files = strcat(filePath, '\', fileType);
files = dir(files);

for i = StartPos : length(files)  
    StartFrame = 3;
    videoName = files(i).name;
    video = VideoReader([filePath, '\', videoName]);     
    
    numFrames = video.NumberOfFrames;
    if numFrames <= StartFrame
       StartFrame = 1; 
    else
       StartFrame = 3; 
    end
    image = read(video, StartFrame);
    
    display(['第' num2str(i) '张图片']);
    
    imwrite(image, [savePath, '\', videoName(1:end-4) '.bmp'], 'bmp');
    
end
