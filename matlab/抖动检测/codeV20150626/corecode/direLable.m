function [ ImgInf ] = direLable( basicDir,ImgInf )
%% �����鷽����1��-1���
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

