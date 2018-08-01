
%% ��ͼƬ�ֳ�3X3��С��
%ͼ����_0-8��˳������С��ͼ���

path = 'F:\��������\noleaf\';%ͼƬ
savePath = 'F:\��������\noleaf3X3\';
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(img_path_list);
data = cell(9*len, 1);
count = 1;
for j = 1 : len
    file_path = strcat(path, img_path_list(j).name);
    [~, name, ext] = fileparts(file_path);
    name = strcat(name, '_');
    num = 0;
    if exist(file_path, 'file')
        img = imread(file_path);
        [M, N, K] = size(img);
        sep = 3;
        stride = [floor(M/sep), floor(N/sep)];
        blk_size = floor(stride);
        
        for r = 1 : floor(stride(1)) : M
            for c = 1 : floor(stride(2)) : N
                if (r+blk_size(1)-1)>M || c+blk_size(2)-1>N
                    continue;
                end
                
                blk = img(...
                    r : r+blk_size(1)-1,...
                    c : c+blk_size(2)-1, ...
                    :);
                imwrite(blk, strcat(savePath, name, num2str(num), ext));
                data{count, 1} = strcat(name, num2str(num), ext);
                count = count + 1;
                num = num + 1;
            end
        end
    end
end
excelPath = strcat(savePath, '�ֿ�.xls');
xlswrite(excelPath, data);






