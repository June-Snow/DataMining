function Point = assignPoint(I, PointNum)

%%
Point = cell(1,2);
h = figure(101); set(h, 'Name','Processing','NumberTitle','off');
imshow(I);

%%
for k = 1:1:PointNum
    [x, y] = ginput(1);%���ѡ����
    text(x,y,'o','Color','r'); %������ѡ����
    Point{2}(k) = x;
    Point{1}(k) = y;
end
close (h);

end