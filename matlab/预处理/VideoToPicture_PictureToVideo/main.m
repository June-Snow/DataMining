%  dir_name = 'F:\��Ƶ����\��Ƶ�� 4.1\';
%  save_path = 'F:\��Ƶ����\��1֡\';
%  videoClipsAndPictureClips(save_path, dir_name );

% % save_path = 'F:\��Ƶ����\�ü�ͼƬ��Ƶ\';
% % avi_name = '200';
% % dir_name = 'F:\��Ƶ����\�ü�ͼƬ200\';
% % aviobj = pictureToVideo(save_path, dir_name, avi_name);

% save_path = 'F:\��Ƶ����\�ü�ͼƬ200\';
% dir_name = 'F:\��Ƶ����\��һ֡\';
% M = 100;
% N = 100;
% crop_image = cropCenter(save_path, dir_name, M, N);

%  dir_name = 'F:\��Ƶ����\��Ƶ�� 4.1\';%��5֡->�ֿ飨28*28��->������ԭ·��
%  disk_path = 'E:';
%  videoClipsAndPictureClips(disk_path, dir_name );

num = 1;
stype = 'bmp';
 dir_name = 'F:\��Ƶ����\��Ƶ�� 4.1\';
 save_path = 'F:\��Ƶ����\��Ƶ֡\��һ֡\';
videoClips(save_path, dir_name, num, stype);

% disk_path = 'D:';
% dir_name = 'F:\��Ƶ����\��Ƶ�� 4.1\';
% image_width = 40;
% image_height = 40;
% stride = 50;
% image_stype = 'jpg';
% videoClipsAndPictureClips(disk_path, dir_name, image_width, image_height, stride, image_stype )

% save_path = 'F:\��Ƶ����\�ü�ͼƬ��Ƶ\';
% dir_name = 'F:\��Ƶ����\��5֡\';
% avi_name = 'di��֡';
% pictureToVideo(save_path, dir_name, avi_name);

save_path = 'F:\��Ƶ����\ͼƬ�ü�\�ü�ͼƬ90\';
dir_name = 'F:\��Ƶ����\��5֡\';
M = 90;
N = 90;
cropCenter(save_path,dir_name, M, N)





