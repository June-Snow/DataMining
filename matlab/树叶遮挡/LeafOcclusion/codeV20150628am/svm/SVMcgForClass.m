function [bestacc,bestc,bestg] = SVMcgForClass(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)

%SVMcg cross validation by faruto

%

% by faruto

%Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto BNU

%last modified 2010.01.17


%% 若转载请注明：

% faruto and liyang , LIBSVM-farutoUltimateVersion 

% a toolbox with implements for support vector machines based on libsvm, 2009. 

% 

% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for

% support vector machines, 2001. Software available at

% http://www.csie.ntu.edu.tw/~cjlin/libsvm

%% about the parameters of SVMcg 

if nargin < 10

    accstep = 4.5;

end

if nargin < 8

   cstep = 0.8;

    gstep = 0.8;

end
if nargin < 7

    v = 5;

end

if nargin < 5

    gmax = 8;

    gmin = -8;

end

if nargin < 3

    cmax = 8;

    cmin = -8;

end

%% X:c Y:g cg:CVaccuracy

[X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
%函数功能生成绘制3-D图形所需的网格数据。在计算机中进行绘图操作时， 
%往往需要一些采样点，然后根据这些采样点来绘制出整个图形。在进行3-D绘图操作时，涉及到x、y、z三组数据，而x、y这两组数据可以看做是在Oxy平面内对坐标进行采样得到的坐标对(x, y)。 
%X和Y是两个行列数相同的矩阵，X列值相同，Y行值相同
[m,n] = size(X);

cg = zeros(m,n);



eps = 10^(-4);



%% record acc with different c & g,and find the bestacc with the smallest c

bestc = 1;

bestg = 0.1;

bestacc = 0;

basenum = 2;

for i = 1:m

    for j = 1:n

        cmd = ['-v ',num2str(v),' -c ',num2str( basenum^X(i,j) ),' -g ',num2str( basenum^Y(i,j) )];

        cg(i,j) = svmtrain(train_label, train, cmd);%如果cmd参数中带了-v参数，则是交叉验证。交叉验证返回的不是模型结构，而是交叉验证的平均误差

        

        if cg(i,j) <= 55

            continue;

        end

        

        if cg(i,j) > bestacc     %若精确度高与当前最佳值

            bestacc = cg(i,j);

            bestc = basenum^X(i,j);

            bestg = basenum^Y(i,j);

        end        

        

       if abs( cg(i,j)-bestacc )<=eps && bestc > basenum^X(i,j) %若精确度相同，但是C值小于当前最佳值
            bestacc = cg(i,j);
            bestc = basenum^X(i,j);
            bestg = basenum^Y(i,j);
        end        
        
    end
end
%% to draw the acc with different c & g
figure;
[C,h] = contour(X,Y,cg,70:accstep:100);%在MATLAB中，该函数用于绘制矩阵的等高线
clabel(C,h,'Color','r');
xlabel('log2c','FontSize',12);
ylabel('log2g','FontSize',12);
firstline = 'SVC参数选择结果图(等高线图)[GridSearchMethod]'; 
secondline = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
    ' CVAccuracy=',num2str(bestacc),'%'];
title({firstline;secondline},'Fontsize',12);
grid on; 


figure;
meshc(X,Y,cg); % meshc:带等高线的三维网格曲面函数 

% mesh(X,Y,cg);

% surf(X,Y,cg);

axis([cmin,cmax,gmin,gmax,30,100]);

xlabel('log2c','FontSize',12);

ylabel('log2g','FontSize',12);
zlabel('Accuracy(%)','FontSize',12);
firstline = 'SVC参数选择结果图(3D视图)[GridSearchMethod]'; 
secondline = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
   ' CVAccuracy=',num2str(bestacc),'%'];
title({firstline;secondline},'Fontsize',12);
