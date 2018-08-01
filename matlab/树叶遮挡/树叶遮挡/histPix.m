src = 'C:\Users\litao\Desktop\新建文件夹 (2)\03608\';
files = dir(strcat(src,'*.jpg'));
for i = 1 : length(files);
    I = imread(strcat(src, files(i).name));
    name = regexp(files(i).name,'\.', 'split');
    [m n c]=size(I);
    if(c==3) %RGB pic        
        fid = fopen(strcat('C:\Users\litao\Desktop\新建文件夹 (2)\03608\',name{1},'.txt'),'w');
        for i = 1:m
            for j=1:n
                fprintf(fid,'%d,%d,%d\t',I(i,j,1),I(i,j,2),I(i,j,3));
            end
            fprintf(fid,'\n');
        end
        fclose(fid);
    end
    h = figure;
    subplot(1,2,1);imshow(I);
    subplot(1,2,2);
    siz = size(I);
    I1=reshape(I,siz(1)*siz(2),siz(3));  % 每个颜色通道变为一列
    I1=double(I1);
    [N,X]=hist(I1,[0:1:255]);    % 如果需要小矩形宽一点，划分区域少点，可以把步长改大，比如0:5:255
    bar(X,N(:,[3 2 1]));    % 柱形图，用N(:,[3 2 1])是因为默认绘图的时候采用的颜色顺序为b,g,r,c,m,y,k，跟图片的rgb顺序正好相反，所以把图片列的顺序倒过来，让图片颜色通道跟绘制时的颜色一致
    xlim([0 255])
    hold on 
    plot(X,N(:,[3 2 1]));    % 上边界轮廓
    hold off
    saveas(h,strcat('C:\Users\litao\Desktop\新建文件夹 (2)\03608\', name{1}, '.jpg'));
end
    
