%% RgbToGray         
% disk_path = 'E:';
% dir_name = 'F:\��Ƶ����\ͼƬ�ü�';
% rgbToGray(disk_path, dir_name );
% root = 'F:\��Ƶ����\��Ƶ֡\';
% image_type = 'jpg';
% rgbToGray(root, image_type);

clear all
clc

root = 'F:\��Ƶ����\��Ƶ�� 4.1';
save_file_name = '��Ƶ֡';
video_type = 'avi';
image_type = 'bmp';
flame_num = 1;
videoClips(root,save_file_name, video_type, image_type, flame_num)