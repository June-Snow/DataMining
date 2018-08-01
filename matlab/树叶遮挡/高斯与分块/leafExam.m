img = imread('F:\日常工作\树叶遮挡\新建文件夹\1000009848_00001.jpg');
[N, M, L] = size(img);
coordinates_all = zeros(N, M);
save_coordinate = zeros(36, 1);
count = 1;
for i = 1 : 4 : N - 4
    for j = 1 : 4 : M - 4
        sub_img = img(i : i + 4, j : j + 4, : );
        num = mean(mean(sub_img));
        if((num(2) > num(1)) && (num(2) > num(3)))
            coordinates_all(i, j) = 1;
        end
    end
end

for i = 1 : floor(N/3 - 1) : floor(2*N/3)
    for j = 1 : floor(M/3 - 1) : floor(2*M/3)       
        row1 = 0; row2 = 0;
        col1 = 0; col2 = 0;
        ind = 0;
        for k = i : i + floor(N/3)
            for l = j : j + floor(M/3)
                if ((coordinates_all(k, l) == 1) && (ind ==0))
                    row1 = k; col1 = l;
                    row2 = k; col2 = l;
                    ind = 1;
                end
                if(coordinates_all(k, l) == 1)
                    if(k<row1)
                        row1 = k;
                    end
                    if(k>row2)
                        row2 = k;
                    end
                    if(l<col1)
                        col1 = l;
                    end
                    if(l>col2)
                        col2 = l;
                    end
                end
            end
        end
        save_coordinate(count, 1) = row1;
        save_coordinate(count + 1, 1) = row2;
        save_coordinate(count + 2, 1) = col1;
        save_coordinate(count + 3, 1) = col2;
        count = count + 4;
    end
end
for i = 1: 12: length(save_coordinate)
img(save_coordinate(i, 1), floor(i/12)*floor(M/3) + 1:floor(i/12 + 1)*floor(M/3) + 1,1) =255;
img(save_coordinate(i + 1, 1), floor(i/12)*floor(M/3) + 1:floor(i/12 + 1)*floor(M/3) + 1, 1) =255;
img(floor(i/12)*floor(N/3) + 1:floor(i/12 + 1)*floor(N/3) + 1, save_coordinate(i + 2, 1),1) =255;
img(floor(i/12)*floor(N/3) + 1:floor(i/12 + 1)*floor(N/3)+ 1, save_coordinate(i + 3, 1),1) =255;
img(save_coordinate(i + 4, 1), floor(i/12)*floor(M/3) + 1:floor(i/12 + 1)*floor(M/3)+ 1,1) =255;
img(save_coordinate(i + 5, 1), floor(i/12)*floor(M/3) + 1:floor(i/12 + 1)*floor(M/3)+ 1,1) =255;
img(floor(i/12)*floor(N/3) + 1:floor(i/12 + 1)*floor(N/3)+ 1, save_coordinate(i + 6, 1),1) =255;
img(floor(i/12)*floor(N/3) + 1:floor(i/12 + 1)*floor(N/3)+ 1, save_coordinate(i + 7, 1),1) =255;
img(save_coordinate(i + 8, 1), floor(i/12)*floor(M/3) + 1:floor(i/12 + 1)*floor(M/3)+ 1,1) =255;
img(save_coordinate(i + 9, 1), floor(i/12)*floor(M/3) + 1:floor(i/12 + 1)*floor(M/3)+ 1,1) =255;
img(floor(i/12)*floor(N/3) + 1:floor(i/12 + 1)*floor(N/3)+ 1, save_coordinate(i + 10, 1),1) =255;
img(floor(i/12)*floor(N/3) + 1:floor(i/12 + 1)*floor(N/3)+ 1, save_coordinate(i + 11, 1),1) =255;
end
    img(N/3 : N/3+2, : ,3) = 255;
    img(N*2/3 : N*2/3+2, : , 3) = 255;
    img(: , (M/3) : (M/3)+2 ,3) = 255;
    img(: ,(M*2/3) : (M*2/3)+2, 3) = 255;
imshow(img);
    

