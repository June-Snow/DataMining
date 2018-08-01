%% 
%说明：根据视频第一帧，找出相同视频
%功能：取视频的第一帧，然后相减求均方差，在均方差小于阈值的情况下，如果两个视频不同名，把高清视频文件名改成标清视频名
%参数：path1为低分辨率源文件夹路径，path2为高清源文件夹路径， save_path文件保存路径

path1 = 'E:\WebRoot\相同文件名文件\';%%为低分辨率源文件夹路径
path2 = 'E:\广东3月\相同文件名\';%%为高清源文件夹路径

low_files = generateFolderTree(path1);
high_files = generateFolderTree(path2);

if isempty(low_files);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len1 = length(low_files);

if isempty(high_files);
    error('设定的文件夹内没有任何视频，请重新检查...')
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
move_path = 'E:\广东3月\相同文件名文件相同内容改文件名\';
%mkdir(move_path);
file_name = sortrows(str_name);
len = length(file_name);
i = 1;
while(i <= len)
      name1 = file_name{i};
      %name1 = name1{1};   %将cell类型转换为string类型
    if i < len
        name2 = file_name{i+1};
        if ~strcmp(name1, name2)
            i = i + 1;
        else
            i = i +2;
            %求出文件夹下的文件数
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

            %取视频第一帧,作灰度差，求均方差            
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
                            %移动高分辨率文件
                            source_path = file_path2;%ext1为.ps
                            save_file_path = strcat(move_path, low_name, ext1);%ext1为.ps
                            if exist(source_path, 'file')
                                movefile(source_path, save_file_path);
                            end
                            %移动低分辨率文件
                            source_path = file_path1;%ext1为.ps
                            save_file_path = strcat(move_path, low_name,'low', ext1);%ext1为.ps
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











