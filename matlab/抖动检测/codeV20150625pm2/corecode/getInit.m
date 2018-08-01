function [ frameLen,SearScop ] = getInit( aviVideo,SearScop )
%% 根据搜索长度计算合适的帧采样数和搜索长度
%%
frameLen = aviVideo.NumberOfFrames;
if frameLen > (50 + SearScop);
    frameLen = 50;
else
    frameLen = fix(frameLen/2);
    SearScop = frameLen - 1;% 避免下界为0
end

end

