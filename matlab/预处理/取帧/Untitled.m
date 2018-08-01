%ͼƬ�Ա�
clear all;
clc;
dir_name = 'F:\��Ƶ����\����\';
move_path = 'F:\��Ƶ����\';
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(file_List);
for i = 1 : len-1
    file_path1 = file_List{i};
    if ~exist(file_path1, 'file')
        continue;
    end
    image1 = imread(file_path1);
    image1 = double(rgb2gray(image1));
    [N1, M1, s1] = size(image1);
    for j =i+1 :len
        file_path2 = file_List{j};
        [pathstr, name, ext1] = fileparts(file_path2);
        if ~exist(file_path2, 'file')
            continue;
        end
        image2 = imread(file_path2);
        image2 = double(rgb2gray(image2));
        [N2, M2, s2] = size(image2);
        if N1 == N2 && M1 == M2
            gray_diff = image1(:)-image2(:);
            val = var(gray_diff(:));
            if val < 1500
                %�ƶ��߷ֱ����ļ�
                source_path = file_path2;%ext1Ϊ.ps
                save_file_path = strcat(move_path, name, ext1);%ext1Ϊ.ps
                if exist(source_path, 'file')
                    movefile(source_path, save_file_path);
                end
            end
        end
    end
end