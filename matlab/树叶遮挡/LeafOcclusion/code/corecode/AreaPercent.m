function [ areaPerc ] = AreaPercent(bwLeaf,xNum,yNum)
%% 计算绿叶区域的面积覆盖比
%%   
fun = @(block_struct) AreaBlock(block_struct.data);
areaBlk = blockproc(bwLeaf,[xNum yNum],fun);
areaPerc = mean(areaBlk(:));
end

