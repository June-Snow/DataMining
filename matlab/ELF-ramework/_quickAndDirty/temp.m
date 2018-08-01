function temp

rawPath = 'D:\STUDY\[1] 图像处理\Database\SURDB\树叶遮挡\20_5401.avi';

aviVideo = VideoReader(rawPath);        % 读取.avi格式视频文件
frameLen = aviVideo.NumberOfFrames;

%% opticalflow1
uv1 = op(aviVideo, 1, min(20, frameLen-1));
figure(1);
subplot(131);
drawingField(uv1, 40);
title('opticalflow1');


%% opticalflow2
uv2 = op(aviVideo, 21, min(20, frameLen-1));
subplot(132);
drawingField(uv2, 40);
title('opticalflow1');


%% opticalflow3
subplot(133);
uv = uv1-uv2;
mu = repmat(mean(uv, 3), [1, 1 ,2]);
uv = (uv - mu) / (max(uv(:)) - min(uv(:)));

drawingField(uv, 40);
title('opticalflow1');

figure(12);
preImg = read(aviVideo, 20);
curImg = read(aviVideo, 21);
diff = imabsdiff(preImg, curImg);

imshow((diff));

%%
function uv = op(aviVideo, startF, endF)
SZ=170;
frameLen = aviVideo.NumberOfFrames;
preImg = read(aviVideo, startF);
preImg = olCropCenter(preImg, SZ);
curImg = read(aviVideo, min(endF, frameLen-1));
curImg = olCropCenter(curImg, SZ);
YCBCRpre = rgb2ycbcr(preImg);
YCBCRcur = rgb2ycbcr(curImg);
uv = opticalflow_main(YCBCRpre(:,:,2:3), YCBCRcur(:,:,2:3));
