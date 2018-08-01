function [ ImgInf ] = direLable( basicDir,ImgInf )
%% 将两组方向以1、-1标记
%%
len = length(ImgInf(:, 2));
for i = 1 : len
    curDir = array(i, 2);
    if abs(basicDir - curDir) <= 90
        ImgInf(i, 2) = 1;
    else
        ImgInf(i, 2) = -1;
    end
end
end

