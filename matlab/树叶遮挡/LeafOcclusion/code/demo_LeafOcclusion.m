set_startup;

%%
FILEDIR  = '..\data\jitter\';
FILEEXT  = '*.avi';
FILES    = dir(fullfile(FILEDIR, FILEEXT));
FILENUM  = size(FILES, 1);

START    = 1;
Mrow     = 288;
Mcol     = 352;
FrameLen = 24;
Tol = 10;%像素幅度容差
Thr = 0.5;%累积帧差概率
xNum = 5;%分块
yNum = 5;
%%
for i = START : START+FILENUM-1    
    filename  = [FILEDIR,FILES(i,1).name];
    disp(['Now processing video:', filename]);
    aviVideo  = VideoReader(filename);        % 读取.avi格式视频文件  
    VideoInf = LeafOcclusion_main(aviVideo, Mrow, Mcol,FrameLen,Tol,Thr,xNum,yNum);     
end




