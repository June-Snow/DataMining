function [ areaPerc ] = AreaPercent(bwLeaf,xNum,yNum)
%% ������Ҷ�����������Ǳ�
%%   
fun = @(block_struct) AreaBlock(block_struct.data);
areaBlk = blockproc(bwLeaf,[xNum yNum],fun);
areaPerc = mean(areaBlk(:));
end

