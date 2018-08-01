function  position = threshold(priori, matcell)
%% 求最优阈值，priori是先验概率，matcell，第一列是频繁项组合，第二列是树叶概率，第三列是正常概率
threshold = 1;
position = 0;
percent_s = cell2mat(matcell(:, 2));
percent_n = cell2mat(matcell(:, 3));
for j = 1 : length(percent_s)
    min_sum = 0;
    if(percent_n(1, 1) < percent_s(1, 1))
        for k = 1 : j
            min_sum = min_sum + priori * percent_n(k, 1);
        end
        for k = j : length(percent_s)
            min_sum = min_sum + (1 - priori) * percent_s(k, 1);
        end
    else
        for k = 1 : j
            min_sum = min_sum + (1 - priori) * percent_s(k, 1);
        end
        for k = j : length(percent_s)
            min_sum = min_sum + priori * percent_n(k, 1);
        end
    end
    if(j == 1)
        threshold = min_sum;
    end
    if threshold > min_sum
        threshold = min_sum;
        position = j;
    end
end

%RectangularCoordinates(percent_s, percent_n, position);

x1 = 1 : length(percent_n);
plot(x1, percent_n, '-o', x1, percent_s, '-*');
hleg1 = legend('p_1(z)', 'p_2(z)');
ylabel('p(z)');
xlabel('z');
hold on;
n = percent_n(1, 1)/3*2;
A = [position position];
B = [0 n];
plot(A, B, ':');
text(position, n, ['\leftarrow T = ', num2str(position)]);
%text(position + 1, n, );
hold off;
% for j = 1 : position
%     text(length(percent_s), (0.1 - 0.01 * j), matcell(j, 1), 'FontSize', 16);
% end

%建立直角坐标系
% n = percent_n(1, 1);
% x=0:length(percent_n)+2; y=0:0.05:0.25;
% x_max = length(percent_n)+2;
% y_max = 0.25;
% axis off; 
% hold on;
% plot([0 0],[min(y) max(y)],'k',[min(x) max(x)],[0 0],'k');%坐标轴颜色
% ax=[max(x),max(x)-x_max/50,max(x)-x_max/50;0,y_max/75,-y_max/75];%画箭头，箭头的二维坐标
% fill(ax(1,:),ax(2,:),'k');%箭头填充
% ay=[0,x_max/75,-x_max/75;max(y),max(y)-y_max/75*2,max(y)-y_max/75*2];
% fill(ay(1,:),ay(2,:),'k'); hold on
% for i=1:floor(length(percent_n)/20):length(x)-2
%     if x(i)~=0
%         plot([x(i),x(i)],[0,y_max/150],'k'); hold on
%         a=text(x(i),-y_max/75*2,num2str(x(i)));
%         set(a,'HorizontalAlignment','center')
%     end
% end
% for i = 1 :length(y) - 0.05
%     if y(i)~=0
%         plot([0,x_max/150],[y(i),y(i)],'k'); hold on
%         b=text(-x_max/75*2,y(i),num2str(y(i)));
%         set(b,'HorizontalAlignment','center')
%     end
% end
% c=text(-x_max/75*2,-y_max/75*2,num2str(0));
% set(c,'HorizontalAlignment','center')
% 
% 
% x1 = 1 : length(percent_n);
% plot(x1, percent_s, x1, percent_n);
% hleg1 = legend('p_1(x)', 'p_2(x)');
% ylabel('p(x)');
% xlabel('x');
% 
% title(position);
% for j = 1 : position
%     %text(length(percent_s), (0.1 - 0.01 * j), matcell(j, 1), 'FontSize', 16);
% end
% 
% hold off;
end


