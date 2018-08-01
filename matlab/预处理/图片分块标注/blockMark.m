function blockMark(save_path, resource_path, Mrow, Mcol)
%%
%function:对每一个块做一个标注。
%如果分块符合要求就点击一次该块，该块会标注为1。不符合要求就不要点击该块，该块的标注会默认为0
%如果误点击，点击2次可以取消对该块的标注。
%variable：save_path：文件保存路径, 文件名为MrowMcol.txt。
%resource_path：源文件路径,
%Mrow：垂直块数,
%Mcol：水平块数。
file_List = getAllFiles(resource_path);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
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
        save_path = strcat(pathstr, '\', '含树叶图片');
        if ~isdir(save_path)
            mkdir(save_path);
        end
        copyfile(path, save_path);
    end
end
fclose(fid);

