function imageClip(save_txt_path, imagepath, col, row)
%% ��ͼƬ�ֳ�row*col�ķ��飬����Ŀ��ڱ�����ַ�����Ϊ1��û�е����Ϊ0
%src = 'F:\�оֵڶ�������ͼƬ����\0019 ��Ҷ�ڵ�\';
%fid = fopen(strcat('F:\�оֵڶ�������ͼƬ����\0019 ��Ҷ�ڵ�', '.txt'), 'w');
fid = fopen(save_txt_path, 'w');
% col = 6;  %ͼƬ�ֳɵ�����
% row = 6;
file_List = getAllFiles(imagepath);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
count = zeros(row, col);
%ͼƬ�ֿ飬ת����01�ַ���
for i = 1 : length(file_List)
    img_path = file_List{i};
    %[pathstr, name, ext] = fileparts(img_path);
    img = imread(img_path);
    [M, N, L] = size(img);
    for j = 1 : row - 1
        img(floor(M*j/row) : floor(M*j/row) + 1, :, :) = 255;
    end
    
    for j = 1 : col - 1
        img(:, floor(N*j/col) : floor(N*j/col) + 1, :) = 255;
    end
    
    imshow(img);
    [x, y]=getpts;    %��ȡ���λ������
    for j = 1 : length(x)
        a = floor(x(j)/(N/col));
        b = floor(y(j)/(M/row));
        count(b + 1, a + 1) = 1;
    end
    
    num = 0;
    for j = 1 : row
        for k = 1 : col
            num = num + count(j, k);
        end
    end
  
    if(num ~= 0)
        for j = 1 : row
            for k = 1 : col
                fprintf(fid, '%d', count(j, k)); %д��txt�ļ���
            end
        end
        fprintf(fid,'\t');
    else
        movefile(file_List{i}, 'F:\�оֵڶ�������ͼƬ����\�½��ļ���\');%�Ѳ���ͬ��ͼƬ�Ƶ������ļ���
    end
    count(1 : row, 1 : col) = 0; 
end
fclose(fid);
end
