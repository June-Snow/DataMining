%% ELO���ŵ�������ͳ��

% path = 'C:\Users\LiTao\Desktop\ELO��������\';
% len = 1500;
% for i = 1 : 10
%     ELOiterater(path, len);
% end

%% ����ļ�����SROCC��ֵͳ��

% path = 'E:\leafOcclusion\b-Part2-leaf\';
% sroccNum = ELORatingSROOC(path);

%% ��3X5��15����
% path = 'C:\Users\LiTao\Desktop\��Ҷ�ڵ�\';
% img_path_list = dir([path,'*.jpg']);
% if isempty(img_path_list);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len = length(img_path_list);
% path2 = 'C:\Users\LiTao\Desktop\�½��ļ���\';
% for i=1 : len
%     file_path = strcat(path, img_path_list(i).name);
%     [~, name, ext] = fileparts(file_path);
%     if exist(file_path, 'file')
%         image = imread(file_path);
%         [M, N, ~] = size(image);
%         image(round(M/3): round(M/3)+1, :, 1) = 255;
%         image(round(2*M/3): round(2*M/3)+1, :, 1) = 255;
%         
%         image(:, round(N/5): round(N/5)+1, 1) = 255;
%         image(:, round(2*N/5): round(2*N/5)+1, 1) = 255;
%         image(:, round(3*N/5): round(3*N/5)+1, 1) = 255;
%         image(:, round(4*N/5): round(4*N/5)+1, 1) = 255;
%         imwrite(image, [path2, name, ext]);
%     end
% end

%% ��ͼƬ�к�ɫ����óɰ�ɫ����
path = 'C:\Users\Serissa\Desktop\�½��ļ���\';
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(img_path_list);
path2 = 'C:\Users\Serissa\Desktop\�½��ļ��� (2)\';
for i=1 : len
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    if exist(file_path, 'file')
        image = imread(file_path);
        [M, N, ~] = size(image);
        for j = 1 : M
            for k = 1 : N
                if (image(j, k, 1) > 180)
                    image(j, k, :) = 255;
                end
            end
        end
        figure;
        imshow(image);
        imwrite(image, [path2, name, ext]);
    end
end