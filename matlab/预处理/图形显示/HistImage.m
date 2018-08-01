y=[0.786041 0.707634;0.748533 0.613269;0.715752 0.542430;0.678522 0.482047;0.623774 0.426481];
% y1 = [0.786041 ,0.748533, 0.715752, 0.678522, 0.623774];
% x = 1 : 5;
bar(y,'hist');
%plot(x, y1);
title('corel');grid on;
set(gca,'xticklabel',20:20:100);
xlabel('Precision @ topK');
ylabel('Precision');