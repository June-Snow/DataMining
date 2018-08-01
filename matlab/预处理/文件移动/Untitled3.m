%% 
%说明：从文件夹中找出与文件同名且内容想相同的avi文件
%功能：把两个文件夹中相同文件名的剪切到一个文件夹下的两个文件夹中
%参数：path1为源文件夹路径，path2为高清源文件夹路径， move_path文件保存路径
path1 = '';
path2 = '';
move_path = '';
file_List1 = getAllFiles(path1);
if isempty(file_List1);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len1 = length(file_List1);

high_files = generateFolderTree(path2);
if isempty(high_files);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
len2 = length(high_files);
str_name = cell(len1+len2,1);
for i = 1 : len1
    file_path1 = file_List1{i};
    [pathstr, name1, ext1] = fileparts(file_path1);
    str_name(i) = {name1};
end
for i = 1 : len2
    path = high_files{i};
    index = strfind(path, '\');
    str_name{i+len1} = path(index(end)+1: end);   
end

file_name = sortrows(str_name);
len = length(file_name);
i = 1;
while(i <= len)
      name1 = file_name(i);
      name1 = name1{1};   %将cell类型转换为string类型
    if i < len
        name2 = file_name(i+1);
        name2 = name2{1};
        if ~strcmp(name1, name2)
            i = i + 1;
        else
            i = i +2;
            %移动低分辨率文件
            file_path = strcat(path1, name1,'.avi');
            [file_info] = aviinfo(file_path);
            
            if file_info.NumFrames == 0
                continue;
            end
            video = VideoReader(file_path);
            image1 = read(video, 1);
            
            path_low = strcat(path2, name1, '\');
            file_List1 = getAllFiles(path_low);
            if ~isempty(file_List1);
                for j = 1 : length(file_List1)
                    file_path1 = file_List1{j};
                    [pathstr, low_name, ext1] = fileparts(file_path1);
                    
                    [file_info] = aviinfo(file_path1);
                    
                    if file_info.NumFrames == 0
                        continue;
                    end
                    video = VideoReader(file_path1);
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
                        source_path = file_path1;%ext1为.ps
                        save_file_path = strcat(move_path, name1, ext1);%ext1为.ps
                        if exist(source_path, 'file')
                            movefile(source_path, save_file_path);
                        end
                        %移动低分辨率文件
                        source_path = file_path;%ext1为.ps
                        save_file_path = strcat(move_path, name1,'low', ext1);%ext1为.ps
                        if exist(source_path, 'file')
                            movefile(source_path, save_file_path);
                        end
                        break;
                    end
                end                
            end            
        end
    else
         break;
    end
end

