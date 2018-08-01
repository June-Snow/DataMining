function uv = opticalflow_main(preImg, curImg, pointNum, radius, preGray)

%%
if nargin > 4
    Point = assignPoint(preImg, pointNum);        %���ѡ����
    [preImg,curImg] = getSimulateImg(preImg, curImg, Point, pointNum, radius, preGray);
end

%%
uv = estimateFlow(preImg, curImg, 'pyramid_levels', 3);

end