%%
%˵�����޳�������ͬ����Ƶ
%���ܣ����ļ�����������ͬ����Ƶ���е���һ���ļ���
%������path1ΪԴ�ļ���·����path2Ϊ�ƶ��ļ�·����abnormal_pathΪ�쳣��Ƶ����·��
%function eliminateSameVideoContent(path1)
% clear all;
% clc;
path1 = 'C:\Users\Serissa\Desktop\�������ƶȲ�����Ƶ\';%%ps�ļ�
path2 = strcat(path1,'\��ͬ��Ƶ\');%%ps�ļ�
abnormal_path = strcat(path1,'\�쳣��Ƶ\');

file_List = getAllFiles(path1);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(file_List);

mkdir(path2);
mkdir(abnormal_path);
for i = 1 : len
    file_path = file_List{i};  
    [file_info] = aviinfo(file_path);
    if file_info.NumFrames == 0       %�޳��쳣��Ƶ
        if exist(file_path, 'file')
            [~, name, ext] = fileparts(file_path);
            save_file_path = strcat(abnormal_path, name, ext);
            movefile(file_path, save_file_path);
        end
    end
end

for i=1 : len-1
    file_path1 = file_List{i};
    [~, name1, ext1] = fileparts(file_path1);
    indx = strfind(name1, '_');
    str_name1 = name1(1:indx(end)-1);
    if exist(file_path1, 'file')
        video = VideoReader(file_path1);
        image1 = read(video, 1);
    else
        continue;
    end
    
    for j=i+1 : len
        file_path2 = file_List{j};
        [~, name2, ext2] = fileparts(file_path2);
        indx = strfind(name2, '_');
        str_name2 = name2(1:indx(end)-1);
        if str_name2 == str_name1
            if exist(file_path2, 'file')                
                video = VideoReader(file_path2);
                image2 = read(video, 1);
                
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
                gray_diff = image11(:)-image22(:);
                val = var(gray_diff(:));
                if val < 1500
                    save_file_path = strcat(path2, name2, ext2);
                    if exist(file_path2, 'file')
                        movefile(file_path2, save_file_path);
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
%end





