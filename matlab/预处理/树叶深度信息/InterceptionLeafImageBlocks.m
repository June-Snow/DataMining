%% 
%��������ȡͼ���е���Ҷ�飬��ȡͼ�����������ԭʼͼ���б���
%���룺0����ʾ�����Ե�ǰͼ����м�����ȡ�ֿ飻
%     1����ʾ��ǰ��ȡ�ķֿ�����һ�ν�ȡ�Ŀ������ͬ�����Ϣ����Ҷ�飻
%     2����ʾ��ǰ��ȡ�ķֿ�����һ�ν�ȡ�Ŀ���в�ͬ�������Ϣ����Ҷ�飻

%����������ԭʼͼ����е������ȡ�����ľ�������

path = 'C:\Users\LiTao\Desktop\�½��ļ��� (5)\';%ͼƬ
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(img_path_list);

for j = 1 : len
    file_path = strcat(path, img_path_list(j).name);
    [~, name, ext] = fileparts(file_path);
    %name = name(1:end-6);
    x = input('s');%x=0ͼƬ�ֿ��Ƿ������x=1�뵱ǰ�����ͬ����Ҷ��x=2�뵱ǰ�������һ�β�ͬ����Ҷ
    image = imread(file_path);
    [m, n] = size(image);
    img = image;
    while(x ~= 0)
        [imcroped, point] = imcrop(image);
        point = ceil(point);
        row = point(2);
        col = point(1);
        
        num = 0;% �������»����ľ���
        for i = row : m
            if img(i, col) == 255 
                num = num + 1;          
            else
                down = i;
            end
            if num > 10
                break;
            end
        end
        
        num = 0;% �������ϻ����ľ���
        for i = row : -1: 1
            if img(i, col) == 255 
                num = num + 1;   
            else
                up = i;
            end
%             if img(i, col) == img(row, col)
%                 up = i;
%             else
%                 num = num + 1;   
%             end
            if num > 10
                break;

            end            
        end        
         num = 0;% �������󻬶��ľ���
        for i = col : -1: 1
            if img(row, i) == 255 
                num = num + 1;   
            else
                left = i;
            end
            if num > 10
                break;
            end            
        end   
         num = 0;% �������һ����ľ���
        for i = col : n
            if img(row, i) == 255 
                num = num + 1;   
            else
                right = i;
            end
            if num > 10
                break;
            end            
        end   
        img(up:down+1, left:right) = img(row, col);
         %figure;imshow(img);
        x = input('s');        
    end
    imwrite(img, strcat(path, name, ext));    
end








