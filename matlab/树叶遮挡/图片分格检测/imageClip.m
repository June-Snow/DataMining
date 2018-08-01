function imageClip(save_txt_path, imagepath, col, row)
%% 把图片分成row*col的方块，点击的块在保存的字符串中为1，没有点击的为0
%src = 'F:\市局第二次样本图片整理\0019 树叶遮挡\';
%fid = fopen(strcat('F:\市局第二次样本图片整理\0019 树叶遮挡', '.txt'), 'w');
fid = fopen(save_txt_path, 'w');
% col = 6;  %图片分成的行列
% row = 6;
file_List = getAllFiles(imagepath);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
count = zeros(row, col);
%图片分块，转换成01字符串
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
    [x, y]=getpts;    %获取鼠标位置坐标
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
                fprintf(fid, '%d', count(j, k)); %写入txt文件中
            end
        end
        fprintf(fid,'\t');
    else
        movefile(file_List{i}, 'F:\市局第二次样本图片整理\新建文件夹\');%把不是同类图片移到其他文件夹
    end
    count(1 : row, 1 : col) = 0; 
end
fclose(fid);
end
