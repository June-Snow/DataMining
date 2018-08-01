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
EstShift = 10; %Ԥ��ƫ����
Thr      = 0.1; %�ж���Ƶ��������ֵ��0~1
SearScop = 30;
xNum     = 2;
yNum     = 2;
performance = zeros(FILENUM,5);

%%
for i = START : START+FILENUM-1    
    filename  = [FILEDIR,FILES(i,1).name];
    disp(['Now processing video:', filename]);
    aviVideo  = VideoReader(filename);        % ��ȡ.avi��ʽ��Ƶ�ļ�
    tic
    VideoInf = Jitter_main(aviVideo, Mrow, Mcol, EstShift, Thr, SearScop,xNum, yNum);
    curtime = toc;
    performance(i,:) = [VideoInf,curtime];    
end

accuRatio = sum(performance(:,1)==0)/length(performance(:,1));
timePerVideo = sum(performance(:,2))/length(performance(:,2));



