function blockMark(save_path, resource_path, Mrow, Mcol)
%%
%function:��ÿһ������һ����ע��
%����ֿ����Ҫ��͵��һ�θÿ飬�ÿ���עΪ1��������Ҫ��Ͳ�Ҫ����ÿ飬�ÿ�ı�ע��Ĭ��Ϊ0
%������������2�ο���ȡ���Ըÿ�ı�ע��
%variable��save_path���ļ�����·��, �ļ���ΪMrowMcol.txt��
%resource_path��Դ�ļ�·��,
%Mrow����ֱ����,
%Mcol��ˮƽ������
file_List = getAllFiles(resource_path);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
txt_name = strcat(num2str(Mrow), num2str(Mcol));
for i = 1 : length(file_List)
    path = file_List{i};
    [~, name, ext] = fileparts(path);
    if strcmp(ext, '.txt')
        if strcmp(txt_name, name)
            txt_name = strcat(txt_name, num2str(Mrow), num2str(Mcol));
        end
    end
   
end

path = strcat(save_path, txt_name, '.txt');
 fid = fopen(path, 'wt');


for i = 1 : length(file_List)
  count = zeros(Mrow, Mcol);  
    path = file_List{i};
    [pathstr, ~, ext] = fileparts(path);
    if strcmp(ext, '.avi')
        video = VideoReader(path);
        img = read(video, 1);        
    else
        img = imread(path); 
    end
  
    [M, N, ~] = size(img);
    for j = fix(M/Mrow +1) : fix(M/Mrow+1) : M - 1
        img(j : (j+2),  : ,:) = 255;
    end
    for k = fix(N/Mcol + 1) : fix(N/Mcol + 1) : N - 1
        img( : , k : (k+2),:) = 255;
    end
    
    image(img);
    [x, y]=getpts;
    
    for j = 1 : length(x(:, 1))
        cor_x = fix(x(j, :)/(N/Mcol))+1;
        cor_y = fix(y(j, :)/(M/Mrow))+1;
        count(cor_y, cor_x) = count(cor_y, cor_x) + 1;
    end
    
    for j = 1 : Mrow
        for k = 1 : Mcol
            if count(j, k) == 2
                fprintf(fid, '%d', 0);
            else
                fprintf(fid, '%d', count(j, k));
            end
        end
    end
    fprintf(fid,'\t');
    if sum(count(:)) > 0
        save_path = strcat(pathstr, '\', '����ҶͼƬ');
        if ~isdir(save_path)
            mkdir(save_path);
        end
        copyfile(path, save_path);
    end
end
fclose(fid);

