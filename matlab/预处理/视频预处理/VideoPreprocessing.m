%%
%˵�����޳�������ͬ����Ƶ���޳��쳣��Ƶ
%���ܣ����ļ�����������ͬ����Ƶ���е���һ���ļ���
%������path1ΪԴ�ļ���·��
%function VideoPreprocessing(path1)
%%
path1 = 'J:\20160822 ok\';%%ps�ļ�
path111 = strcat(path1,'*.avi');
img_path_list = dir(path111);
if isempty(img_path_list);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(img_path_list);
same_path = strcat(path1,'��ͬ��Ƶ\');%%
abnormal_path = strcat(path1,'�쳣��Ƶ\');
same_name = cell(1,1);
abnormal_name = cell(1,1);
name_cell = cell(1,1);
%��ȡcurPos�ļ�
fid = fopen(strcat(path1, 'curPos.txt'), 'r');
if fid == -1
    cur_pos = 1;
else
    cur_name = fscanf(fid, '%s');
    fclose(fid);
    index = 0;
    for i = 1 : len
        if strcmp(img_path_list(i).name, cur_name)
            index = i;
        end
    end
    if index > 0
        cur_pos = index;
    else
        cur_pos = 1;
    end
end

mkdir(same_path);
mkdir(abnormal_path);
h = waitbar(cur_pos/len,'Applying ...');%������ʾ�������еĽ���44060422001320100824.avi
set(h, 'Name', 'Progress');%?

for i=cur_pos+1 : len
    close all;
    file_path1 = strcat(path1, img_path_list(i).name);
    [~, name1, ext1] = fileparts(file_path1);
    str_name1 = nameClip(name1);
    if exist(file_path1, 'file')
        try
            video = VideoReader(file_path1);
            image1 = read(video, 1);
        catch err
            save_file_path = strcat(abnormal_path, name1, ext1);
            movefile(file_path1, save_file_path);
            name_cell = strcat(name1, ext1);
            abnormal_name = [abnormal_name; name_cell];
            continue;
        end       
        
        %���浱ǰ����λ��
        fp = fopen(strcat(path1, 'curPos.txt'), 'wt');
        fprintf(fp, '%s\r\n', strcat(name1, ext1));
        fclose(fp);
    else
        continue;
    end
    waitbar(i / len);%waitbar(k/steps,hwait,'�������')������hwait�����ϵĻ�������ʾn�������������
    for j=i+1 : len
        file_path2 = strcat(path1, img_path_list(j).name);
        [~, name2, ext2] = fileparts(file_path2);
        str_name2 = nameClip(name2);
        if strcmp(str_name2, str_name1)
            if exist(file_path2, 'file')
                try
                    video = VideoReader(file_path2);
                    image2 = read(video, 1);
                catch err
                    save_file_path = strcat(abnormal_path, name2, ext2);
                    movefile(file_path2, save_file_path);
                    name_cell = strcat(name2, ext2);
                    abnormal_name = [abnormal_name; name_cell];
                    continue;
                end
                
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
                figure;imshow(image1);
                figure;imshow(image2);
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
                                name_cell = strcat(name2, ext2);
                                same_name = [same_name; name_cell];
                            end
                        end
                    elseif image22_diff<3500 && image11_diff<3500
                        if val < 3000
                            save_file_path = strcat(same_path, name2, ext2);
                            if exist(file_path2, 'file')
                                movefile(file_path2, save_file_path);
                                name_cell = strcat(name2, ext2);
                                same_name = [same_name; name_cell];
                            end
                        end
                    else
                        if val < 4000
                            save_file_path = strcat(same_path, name2, ext2);
                            if exist(file_path2, 'file')
                                movefile(file_path2, save_file_path);
                                name_cell = strcat(name2, ext2);
                                same_name = [same_name; name_cell];
                            end
                        end
                    end
                end
            else
                continue;
            end
        else
            break;
        end
    end
end
close(h);

fp1 = fopen(strcat(same_path, 'sameAVI.txt'), 'a');
for i = 2 : length(same_name(:, 1))
    fprintf(fp1, '%s\r\n', same_name{i, 1});
end
fclose(fp1);

fp2 = fopen(strcat(abnormal_path, 'abnormalAVI.txt'), 'a');
for i = 2 : length(abnormal_name)
    fprintf(fp2, '%s\r\n', abnormal_name{i, 1});
end
fclose(fp2);
%end




