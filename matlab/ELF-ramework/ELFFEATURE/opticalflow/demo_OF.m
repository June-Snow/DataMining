set_startup;

%%
FILEDIR  = '..\data\RealVideo\';
FILEEXT  = '.avi';

FILEDIR2  = '..\data\RealFlowData\Data_real1\';
FILEEXT2 = '*.mat';
FILES = dir(fullfile(FILEDIR2, FILEEXT2));

FILENUM  = 1;
START    = 1;

Mrows = 288;
Mcols = 352;
pointNum = 2;   % ��������
radius   = 8;   % �����Ĵ�С
preGrey  = 51;  % �����ĻҶ�ֵ��0-255��
%%
for i = START:START+FILENUM-1
    
    filename = [FILEDIR,num2str(i),FILEEXT];
    disp(['Now processing video:',filename]);
    aviVideo = VideoReader(filename);        % ��ȡ.avi��ʽ��Ƶ�ļ�
    frameLen = aviVideo.NumberOfFrames;
   
    for k = 40:50
        preImg = read(aviVideo, k);
        curImg = read(aviVideo, k+1);
        tic;
        uv = opticalflow_main(preImg, curImg);
        toc
        
        drawingField(uv, 40);
             
    end
end