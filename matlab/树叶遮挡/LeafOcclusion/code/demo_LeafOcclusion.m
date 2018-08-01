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
Tol = 10;%���ط����ݲ�
Thr = 0.5;%�ۻ�֡�����
xNum = 5;%�ֿ�
yNum = 5;
%%
for i = START : START+FILENUM-1    
    filename  = [FILEDIR,FILES(i,1).name];
    disp(['Now processing video:', filename]);
    aviVideo  = VideoReader(filename);        % ��ȡ.avi��ʽ��Ƶ�ļ�  
    VideoInf = LeafOcclusion_main(aviVideo, Mrow, Mcol,FrameLen,Tol,Thr,xNum,yNum);     
end




