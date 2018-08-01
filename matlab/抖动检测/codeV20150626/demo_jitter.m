set_startup;

%%
FILEDIR  = '..\data\jitter\';
FILEEXT  = '*.avi';
FILES    = dir(fullfile(FILEDIR, FILEEXT));
FILENUM  = size(FILES, 1);

START    = 2;
%FILENUM  = 1;
Mrow     = 288;
Mcol     = 352;
EstShift = 10; %预估偏移量
Thr      = 0.1; %判断视频抖动的阈值，0~1
SearScop = 30;
xNum     = 2;
yNum     = 2;
performance = zeros(FILENUM,5);

%%
for i = START : START+FILENUM-1    
    filename  = [FILEDIR,FILES(i,1).name];
    disp(['Now processing video:', filename]);
    aviVideo  = VideoReader(filename);        % 读取.avi格式视频文件
    tic
    VideoInf = Jitter_main(aviVideo, Mrow, Mcol, EstShift, Thr, SearScop,xNum, yNum);
    curtime = toc;
    performance(i,:) = [VideoInf,curtime];    
end

accuRatio = sum(performance(:,1)==0)/length(performance(:,1));
timePerVideo = sum(performance(:,2))/length(performance(:,2));



