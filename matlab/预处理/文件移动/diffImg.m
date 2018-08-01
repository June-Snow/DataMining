%% 
%˵����������Ƶ��һ֡���ҳ���ͬ��Ƶ
%���ܣ�ȡ��Ƶ�ĵ�һ֡��Ȼ������������ھ�����С����ֵ������£����������Ƶ��ͬ�����Ѹ�����Ƶ�ļ����ĳɱ�����Ƶ��
%������path1Ϊ�ͷֱ���Դ�ļ���·����path2Ϊ����Դ�ļ���·���� save_path�ļ�����·��

path1 = 'E:\WebRoot\��ͬ�ļ����ļ�\';%%Ϊ�ͷֱ���Դ�ļ���·��
path2 = 'E:\�㶫3��\��ͬ�ļ���\';%%Ϊ����Դ�ļ���·��

low_files = generateFolderTree(path1);
high_files = generateFolderTree(path2);

if isempty(low_files);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len1 = length(low_files);

if isempty(high_files);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len2 = length(high_files);
str_name = cell(len1+len2,1);

for i = 1 : len1
    path = low_files{i};
    index = strfind(path, '\');
    str_name{i} = path(index(end)+1: end);
end
for i = 1 : len2
    path = high_files{i};
    index = strfind(path, '\');
    str_name{i+len1} = path(index(end)+1: end);   
end
move_path = 'E:\�㶫3��\��ͬ�ļ����ļ���ͬ���ݸ��ļ���\';
%mkdir(move_path);
file_name = sortrows(str_name);
len = length(file_name);
i = 1;
while(i <= len)
      name1 = file_name{i};
      %name1 = name1{1};   %��cell����ת��Ϊstring����
    if i < len
        name2 = file_name{i+1};
        if ~strcmp(name1, name2)
            i = i + 1;
        else
            i = i +2;
            %����ļ����µ��ļ���
            path_low = strcat(path1, name1, '\');
            file_List1 = getAllFiles(path_low);
            if isempty(file_List1);
                rmdir(path_low);
                %continue;
            end
            len1 = length(file_List1);
            
            path_high = strcat(path2, name2, '\');
            file_List2 = getAllFiles(path_high);
            if isempty(file_List2);
                rmdir(path_high);
                continue;
            end
            len2 = length(file_List2);

            %ȡ��Ƶ��һ֡,���ҶȲ�������            
            for j = 1 : len1
                file_path1 = file_List1{j};
                [pathstr, low_name, ext1] = fileparts(file_path1);
                
                [file_info] = aviinfo(file_path1);
                
                if file_info.NumFrames == 0 
                    continue;
                end
                video = VideoReader(file_path1);
                image1 = read(video, 1);
                for k = 1 : len2
                    file_path2 = file_List2{k};
                    if exist(file_path2, 'file')
                        [file_info] = aviinfo(file_path2);
                        if file_info.NumFrames == 0 
                            continue;
                        end
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
                            %�ƶ��߷ֱ����ļ�
                            source_path = file_path2;%ext1Ϊ.ps
                            save_file_path = strcat(move_path, low_name, ext1);%ext1Ϊ.ps
                            if exist(source_path, 'file')
                                movefile(source_path, save_file_path);
                            end
                            %�ƶ��ͷֱ����ļ�
                            source_path = file_path1;%ext1Ϊ.ps
                            save_file_path = strcat(move_path, low_name,'low', ext1);%ext1Ϊ.ps
                            if exist(source_path, 'file')
                                movefile(source_path, save_file_path);
                            end
                            break;
                        end
                    end
                end
            end
        end
    else
         break;
    end
end











