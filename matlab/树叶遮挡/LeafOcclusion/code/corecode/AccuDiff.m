function [ leafMap ] = AccuDiff( aviVideo, Mrow, Mcol,FrameLen, Tol)
%% �ۻ�֡��ָ���Ҷ����,����ÿ��������Ҷ����ĸ��ʣ�0~1
%%
startframe = 1;
endframe = startframe+FrameLen-1;
diffFrame = zeros( Mrow,Mcol,FrameLen);
%%
for fNo = startframe : endframe     
    curImg = read(aviVideo, fNo);
    curImg = preProcess(curImg, Mrow, Mcol);
    nextImg = read(aviVideo,fNo+1);       
    nextImg = preProcess(nextImg, Mrow, Mcol); 
    diffFrame(:,:,fNo) = abs(curImg-nextImg); 
end
diffFrame = diffFrame > Tol;
accuDiffFrame = sum(diffFrame,3);
leafMap = accuDiffFrame/FrameLen;

end

