function [ areaBlk ] = AreaBlock( block )
%% 计算每一个块中的树叶覆盖面积
%%
[r,c] = size(block);
top = sum(block(1,:));
bottom = sum(block(end,:));
left = sum(block(:,1));
right = sum(block(:,end));
edgeNum = top==c + bottom==c + left==r + right==r;
switch(edgeNum)
    case(0)
        areaBlk =  0;
    case(1)
        areaBlk =  0;
    case(2)
        areaBlk =  0.5;
    case(3)
        areaBlk =  1;
    case(4)
        areaBlk =  1;           
end
end

