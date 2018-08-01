src = 'C:\Users\litao\Desktop\新建文件夹 (3)\';
file_List = getAllFiles(src);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
fid = fopen(strcat('C:\Users\litao\Desktop\树叶遮挡检测\树叶遮挡1', '.txt'), 'w');
count = zeros(1, 9);
for i = 1 : length(file_List)
    img_path = file_List{i};
    img = imread(img_path);
    [M, N, L] = size(img);
    img(M/3 : M/3+2, : ,:) = 255;
    img(M*2/3 : M*2/3+2, : , :) = 255;
    img(: , (N/3) : (N/3)+2 ,:) = 255;
    img(: ,(N*2/3) : (N*2/3)+2, :) = 255;
    image(img);
    [x, y]=getpts;
    
    for j = 1:length(x)
        if (x(j)<N/3 && y(j)<M/3)
            count(1,1) = count(1,1) + 1;
        end
        if ((N/3)<x(j) && x(j)<(2*N/3) && y(j)<(M/3))
            count(1, 2) = count(1, 2) + 1;
        end
        if ((2*N/3)<x(j) && x(j)<N && y(j)<(M/3))
            count(1, 3) = count(1, 3) + 1;
        end
        if (x(j)<(N/3) && (M/3)<y(j) && y(j)<(2*M/3))
            count(1, 4) = count(1, 4) + 1;
        end
        if (N/3<x(j) && x(j)<(2*N/3) && M/3<y(j) && y(j)<(2*M/3))
            count(1, 5) = count(1, 5) + 1;
        end
        if ((2*N/3)<x(j) && x(j)<N && (M/3)<y(j) && y(j)<(2*M/3))
            count(1, 6) = count(1, 6) + 1;
        end
        if (x(j)<N/3 && (2*M/3)<y(j) && y(j)<M)
            count(1, 7) = count(1, 7) + 1;
        end
        if (N/3<x(j) && x(j)<(2*N/3) && (2*M/3)<y(j) && y(j)<M)
            count(1, 8) = count(1, 8) + 1;
        end
        if ((2*N/3)<x(j) && x(j)<N && (2*M/3)<y(j) && y(j)<M)
            count(1, 9) = count(1, 9) + 1;
        end
    end
    for k = 1:9
        fprintf(fid, '%d', count(1, k));
    end
   fprintf(fid,'\t');
    count(1,1:9) = 0;
    %imwrite(img,strcat('C:\Users\litao\Desktop\新建文件夹\','1.jpg'));
   
end
fclose(fid);