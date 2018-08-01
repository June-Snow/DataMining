function [ToImg1,ToImg2] = getSimulateImg(FroImg1,FroImg2,Point,pointNum,radius,preGray)

%%
Point_h = Point{1,1};
Point_w = Point{1,2};

for k = 1:1:pointNum
    FroImg1(Point_h(k):Point_h(k)+radius, Point_w(k):Point_w(k)+radius,:) = preGray;
    FroImg2(Point_h(k):Point_h(k)+radius, Point_w(k):Point_w(k)+radius,:) = preGray;
end
ToImg1 = FroImg1;
ToImg2 = FroImg2;

end