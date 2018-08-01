function RectangularCoordinates(percent_s, percent_n, position)
%% 直角坐标系 
x=0 : length(percent_n) + 2;%30; 
y=0 : 0.05 : percent_n(1, 1) + 0.1;%0.25;
x_max = length(percent_n) + round(length(percent_n)/20);%30;
y_max = max(y);%0.25;
axis off; 
hold on;
plot([0 0],[min(y) max(y)],'k',[min(x) max(x)],[0 0],'k');%坐标轴颜色
ax=[max(x),max(x)-x_max/50,max(x)-x_max/50;0,y_max/75,-y_max/75];%画箭头，箭头的二维坐标
fill(ax(1,:),ax(2,:),'k');%箭头填充
ay=[0,x_max/75,-x_max/75;max(y),max(y)-y_max/75*2,max(y)-y_max/75*2];
fill(ay(1,:),ay(2,:),'k'); hold on

for i=1 : round(length(percent_n)/20) : length(x) - round(length(percent_n)/20)/2
    if x(i)~=0
        plot([x(i),x(i)],[0,y_max/150],'k'); hold on
        a=text(x(i),-y_max/75*2,num2str(x(i)));
        set(a,'HorizontalAlignment','center')
    end
end
for i = 1 : length(y) - 0.05
    if y(i)~=0
        plot([0,x_max/150],[y(i),y(i)],'k'); hold on
        b=text(-x_max/75*2,y(i),num2str(y(i)));
        set(b,'HorizontalAlignment','center')
    end
end
c=text(-x_max/75*2,-y_max/75*2,num2str(0));
set(c,'HorizontalAlignment','center')

x1 = 1 : length(percent_n);
plot(x1, percent_s, x1, percent_n);
hleg1 = legend('p_1(x)', 'p_2(x)');

% ylabel('p(x)');
% xlabel('x');
a=text(x_max, -y_max/75*2, 'x');
set(a,'HorizontalAlignment','center')
b=text(-x_max/75*2, y_max, 'p(x)');
set(b,'HorizontalAlignment','center')
        
title(position);
for j = 1 : position
%    text(length(percent_s), (0.1 - 0.01 * j), matcell(j, 1), 'FontSize', 16);
end
end
