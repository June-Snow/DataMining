function [  blockInf ] = getBlockInf( curImg,refImg,Mrow, Mcol,xNum,yNum,EstShift)
%% �ֿ飬����ÿһ���ƫ����
% ��ƫ��Ϊ������ƫ��Ϊ��
% ��ƫ��Ϊ������ƫ��Ϊ��
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
        WminCol = -WminCol;%��ƫ��Ϊ������ƫ��Ϊ��
        WminRow = CorrCoef(refColProjValue,curColProjValue, EstShift);%��ƫ��Ϊ������ƫ��Ϊ��        
        blockInf(i,j,:) = [WminRow,WminCol];
    end
end

end

