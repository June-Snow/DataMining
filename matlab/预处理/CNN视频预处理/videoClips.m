%function videoClips(dir_name, frame_num, image_stype )
%%��ȡ�ļ�·��
clear all;
clc;
frame_num = 1;
image_stype = 'jpg';
replace_name = '��Ҷ�ڵ�ͼƬ';
dir_name = 'F:\litao\��Ҷ�ڵ�';
%videoClips(dir_name, num, stype);

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end

for i = 1 : length(file_List)
    %% ��ȡ��Ƶ
    video_path = file_List{i};
    [pathstr, name, ext] = fileparts(video_path);
    if strcmp(ext,  '.avi')
        video = VideoReader(video_path);
        all_name = regexp(video.name, '\.', 'split');
        image_name = all_name{1};
        save_path = strrep(video.Path,'��Ҷ�ڵ�',replace_name);
        dir_path = strrep(save_path, '\', '/');
        %% ��ȡ��һ֡
        for j = 1 : 1%video.NumberOfFrames
            image = read(video, j);         %����ͼƬ
%             figure;
%             imshow(image);
        end
        if ~isdir(dir_path)
            mkdir(dir_path);
        end
        %         mkdir(dir_path);
                 imwrite(image, strcat(dir_path,'\', image_name, '.', image_stype));
    end
end

