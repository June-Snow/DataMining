%%
%说明：剔除内容相同的视频，剔除异常视频
%功能：把文件夹中内容相同的视频剪切到另一个文件夹
%参数：path1为源文件夹路径
%%
path1 = 'C:\Users\LiTao\Desktop\树叶深度信息\树叶排序\';%%ps文件
path111 = strcat(path1,'*.jpg');
img_path_list = dir(path111);
if isempty(img_path_list);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len = length(img_path_list);
same_path = strcat(path1,'相同视频\');%%
abnormal_path = strcat(path1,'异常视频\');
mkdir(same_path);
mkdir(abnormal_path);
h = waitbar(1/len,'Applying ...');%用于显示程序运行的进度
set(h, 'Name', 'Progress');%?

for i=1 : len-1
    file_path1 = strcat(path1, img_path_list(i).name);
    [~, name1, ext1] = fileparts(file_path1);
    if exist(file_path1, 'file')
        image1 = imread(file_path1);
    else
        continue;
    end
    waitbar(i / len);%waitbar(k/steps,hwait,'即将完成')如果这个hwait不加上的话，会显示n多个进度条窗口
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







