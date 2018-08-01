function [  blockInf ] = getBlockInf( curImg,refImg,Mrow, Mcol,xNum,yNum,EstShift)
%% 分块，计算每一块的偏移量
% 左偏移为负，右偏移为正
% 上偏移为正，下偏移为负
%%
blockInf = zeros(xNum,yNum,2);
blkX = fix(Mrow / xNum);
blkY = fix(Mcol / yNum);
for i = 1:xNum
    for j = 1:yNum
        xStart = 1    + (i-1)*blkX;
        xEnd   = blkX + (i-1)*blkX;
        yStart = 1    + (j-1)*blkY;
        yEnd   = blkY + (j-1)*blkY;
        subC   = curImg(xStart:xEnd, yStart:yEnd);
        subR   = refImg(xStart:xEnd, yStart:yEnd);
        
        curRowProjValue = GrayProject(subC);
        curColProjValue = GrayProject(subC');
        refRowProjValue = GrayProject(subR);
        refColProjValue = GrayProject(subR');
        
        WminCol = CorrCoef(refRowProjValue,curRowProjValue,EstShift);
        WminCol = -WminCol;%上偏移为正，下偏移为负
        WminRow = CorrCoef(refColProjValue,curColProjValue, EstShift);%左偏移为负，右偏移为正        
        blockInf(i,j,:) = [WminRow,WminCol];
    end
end

end

