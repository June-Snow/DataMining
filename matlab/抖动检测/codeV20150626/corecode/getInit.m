function [ frameLen,SearScop ] = getInit( aviVideo,SearScop )
%% �����������ȼ�����ʵ�֡����������������
%%
frameLen = aviVideo.NumberOfFrames;
if frameLen > (50 + SearScop);
    frameLen = 50;
else
    frameLen = fix(frameLen/2);
    SearScop = frameLen - 1;% �����½�Ϊ0
end

end

