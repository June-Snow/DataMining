%img = imread('F:\�ճ�����\��Ҷ�ڵ�\�½��ļ���\1000053882_00001.jpg');
%%TODO���ݻҶ�ֵ����һ��ȷ��RGBֵ
scr = 'F:\��Ƶ����\��Ƶ֡\0000 ������Ƶ      ��read only��\';
scr_files = dir(strcat(scr, '*.bmp'));
for i = 1 :length(scr_files)
    img = imread(strcat(scr, scr_files(i).name));
    name = regexp(scr_files(i).name,'\.', 'split');
[N, M, L] = size(img);

percent_count = 0;
block_percent = zeros(7, 7);
block_show_img = img;
coordinates_all = zeros(N, M);
center_coordinate = zeros(N, M);
mean_g_val = zeros(N/5, M/5);
template_size = 7;
sigma = 2;
gaunssian_template = gaunssianTemplate(template_size, sigma);
%% ��4*4�Ŀ����������G��ֵ
nor_template = zeros(1, 10);
nor_mean = 0;
x_step = 0.5;
nor_sigma = 2;
X = 0 : x_step : x_step * 10;
y = normpdf(X, 0, nor_sigma);
for j = 1 : 10
    nor_mean = nor_mean + y(j);
end
for j = 1 : 10
    nor_template(j) = y(j) / nor_mean;
end
max_mean = 0;
min_mean = 255;
for j = 1 : 4 : N -4
    for k = 1 : 4 : M -4
        sub_img = img(j : j + 4, k : k + 4, : );
        num = mean(mean(sub_img));
        if((num(2) > (num(1)) ) && (num(2) > (num(3) )))
            if(max_mean < num(2))
                max_mean = num(2);
            end
            if(min_mean > num(2))
                min_mean = num(2);
            end
        end
    end
end
%% ���ÿ���ֿ����Ҷռ��
g_step = (max_mean - min_mean)/10;
for j = 1 : 7
    for k = 1 : 7
        count = 0;
        block_search = img((j - 1)*floor(N/7) + 1 : (j)*floor(N/7), (k - 1)*floor(M/7) + 1 : (k)*floor(M/7), : );
        for l = 1 : 4 : floor(N/7) -4
            for m = 1 : 4 : floor(M/7) - 4
                sub_img = block_search(l : l + 4, m : m + 4, : );
                num = mean(mean(sub_img));
                if((num(2) > (num(1)) ) && (num(2) > (num(3) )))
                    %if()
                    for n = 1 : 10
                        if(((min_mean + (n - 1) * g_step) < num(2))&& ((min_mean + (n * g_step)) > num(2)))
                            count = count + nor_template(n) * 10;
                        end
                    %end
                    end
                end
            end
        end
        percent_count = percent_count + 16 * count/(floor(N/7)*floor(M/7)) * gaunssian_template(j, k);
        %block_percent(j, k) = 16 * count/(floor(N/7)*floor(M/7)) * gaunssian_template(j, k);
    end
end

% for j = floor(N/7) : floor(N/7) : N - floor(N/7)
%     block_show_img(j : j + 1, : , :) = 255; 
% end
% for j = floor(M/7) : floor(M/7) : M - floor(M/7)
%     block_show_img( : , j : j + 1, :) = 255; 
% end
% 
% figure;
% imshow(block_show_img);
%% �ж���Ҷ��λ��
for i = 1 : 4 : N -4
    for j = 1 : 4 : M -4
        sub_img = img(i : i + 4, j : j + 4, : );
        num = mean(mean(sub_img));
        if((num(2) > (num(1)) ) && (num(2) > (num(3) )))
           if ((num(2)-num(1) > 1)&&(num(2)- num(3)>1))
            mean_g_val(floor(i/5)+1,floor(j/5)+1)=num(2);
            
            center_coordinate((2*i + 4)/2, (2*j + 4)/2) = 10;
            coordinates_all(i, j : j+4) = coordinates_all(i, j : j+4) + 1;
            coordinates_all(i + 4, j : j+4) = coordinates_all(i + 4, j : j+4) + 1;
            coordinates_all(i : i+4, j) = coordinates_all(i : i+4, j) + 1;
            coordinates_all(i : i+4, j+4) = coordinates_all(i : i+4, j+4) + 1;
            end
        end
    end
end
%% �����������Ҷ����״
for i = 1 : N 
    for j = 1 : M 
        if((coordinates_all(i, j) == 1)||(coordinates_all(i, j) == 4))
            img(i, j, 1) = 255;
        end
    end
end
%% ��ʾRGB�е�Gֵ
% [row, col] = size(mean_g_val);
% carray = reshape(mean_g_val,row*col,1);
% carray = sort(carray);
% count_x = zeros(255,1);
% count_y = zeros(255,1);
% j = 1;
%  for i = 1 : row*col -1
%  
%      if(floor(carray(i)) == floor(carray(i + 1)))
%          count_y(j) = count_y(j) + 1;
%      else
%          count_x(j) = floor(carray(i));
%          j = j + 1;
%      end
%  end
%    h = figure;
%    plot(count_x(2:255), count_y(2:255))
%    saveas(h,strcat('F:\�ճ�����\��Ҷ�ڵ�\�½��ļ���\', name{1}, '.jpg'));
h = figure;

imshow(img);
title(percent_count);
saveas(h, strcat('C:\Users\LiTao\Desktop\�½��ļ��� (3)\', name{1}, '.jpg'));
close all;
end
%%TODO:�����ɫ�ݶȣ���˫���˲����ȿ��ǿռ�����ֿ�������ֵ֮��Ĳ�ֵ��
%Bilateral blur�ĸĽ��������ڲ���ʱ�������������ڿռ�����ϵĹ�ϵ��ͬʱ���������ؼ����̶ȿ���



