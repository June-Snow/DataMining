%%
%˵�����޳�������ͬ����Ƶ���޳��쳣��Ƶ
%���ܣ����ļ�����������ͬ����Ƶ���е���һ���ļ���
%������path1ΪԴ�ļ���·��
%%
path1 = 'C:\Users\LiTao\Desktop\��Ҷ�����Ϣ\��Ҷ����\';%%ps�ļ�
path111 = strcat(path1,'*.jpg');
img_path_list = dir(path111);
if isempty(img_path_list);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(img_path_list);
same_path = strcat(path1,'��ͬ��Ƶ\');%%
abnormal_path = strcat(path1,'�쳣��Ƶ\');
mkdir(same_path);
mkdir(abnormal_path);
h = waitbar(1/len,'Applying ...');%������ʾ�������еĽ���
set(h, 'Name', 'Progress');%?

for i=1 : len-1
    file_path1 = strcat(path1, img_path_list(i).name);
    [~, name1, ext1] = fileparts(file_path1);
    if exist(file_path1, 'file')
        image1 = imread(file_path1);
    else
        continue;
    end
    waitbar(i / len);%waitbar(k/steps,hwait,'�������')������hwait�����ϵĻ�������ʾn�������������
    for j=i+1 : len
        file_path2 = strcat(path1, img_path_list(j).name);
        [~, name2, ext2] = fileparts(file_path2);
        if exist(file_path2, 'file')
            image2 = imread(file_path2);
            [N1, M1, s1] = size(image1);
            [N2, M2, s2] = size(image2);
            if s1 ~= s2 || N1 ~= N2 || M1 ~= M2 || N1 ==1 || N2 == 1
                continue;
            end
            if s1==3
                image11 = double(rgb2gray(image1));
                image22 = double(rgb2gray(image2));
            else
                image11 = double(image1);
                image22 = double(image2);
            end
            image11_diff = var(image11(:));
            image22_diff = var(image22(:));
            gray_diff = (image11(:)-image22(:));
            val = var(gray_diff(:));
            cccc = abs(image22_diff - image11_diff);
%             figure;imshow(image1);
%             figure;imshow(image2);
            if min(image22_diff, image11_diff)<1600
                break;
            elseif (image11_diff+image22_diff)/2 < val + (image11_diff+image22_diff)*0.1
                break;
            elseif cccc < 1200 && min(image22_diff, image11_diff)<2200
                break;
            else
                if image22_diff<3000 && image11_diff<3000
                    if val < 2500
                        save_file_path = strcat(same_path, name2, ext2);
                        if exist(file_path2, 'file')
                            movefile(file_path2, save_file_path);
                        end
                    end
                elseif image22_diff<3500 && image11_diff<3500
                    if val < 3000
                        save_file_path = strcat(same_path, name2, ext2);
                        if exist(file_path2, 'file')
                            movefile(file_path2, save_file_path);
                        end
                    end
                else
                    if val < 4000
                        save_file_path = strcat(same_path, name2, ext2);
                        if exist(file_path2, 'file')
                            movefile(file_path2, save_file_path);
                        end
                    end
                end
            end
        else
            continue;
        end
    end
end
close(h);







