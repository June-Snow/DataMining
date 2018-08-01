function [ leafMap ] = AccuDiff( aviVideo, Mrow, Mcol,FrameLen,Tol )
%% 累积帧差法分割绿叶区域,返回每个点是绿叶区域的概率，0~1
%%
frame = aviVideo.NumberOfFrames;
if frame < FrameLen
    FrameLen = frame;
end

startframe = 1;
endframe = startframe+FrameLen-2;
diffFrame = zeros( Mrow,Mcol,FrameLen);
%%
for fNo = startframe : endframe     
    curImg = read(aviVideo, fNo);
    curImg = preProcess(curImg, Mrow, Mcol);
    curImg = rgb2gray(curImg);
    nextImg = read(aviVideo,fNo+1);       
    nextImg = preProcess(nextImg, Mrow, Mcol);
    nextImg = rgb2gray(nextImg);
    diffFrame(:,:,fNo) = abs(curImg-nextImg); 
end
diffFrame = diffFrame>Tol;
accuDiffFrame = sum(diffFrame,3);
leafMap = accuDiffFrame/FrameLen;

end

