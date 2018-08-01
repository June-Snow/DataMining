%  dir_name = 'F:\ÊÓÆµ²âÊÔ\ÊÓÆµ¿â 4.1\';
%  save_path = 'F:\ÊÓÆµ²âÊÔ\µÚ1Ö¡\';
%  videoClipsAndPictureClips(save_path, dir_name );

% % save_path = 'F:\ÊÓÆµ²âÊÔ\²Ã¼ôÍ¼Æ¬ÊÓÆµ\';
% % avi_name = '200';
% % dir_name = 'F:\ÊÓÆµ²âÊÔ\²Ã¼ôÍ¼Æ¬200\';
% % aviobj = pictureToVideo(save_path, dir_name, avi_name);

% save_path = 'F:\ÊÓÆµ²âÊÔ\²Ã¼ôÍ¼Æ¬200\';
% dir_name = 'F:\ÊÓÆµ²âÊÔ\µÚÒ»Ö¡\';
% M = 100;
% N = 100;
% crop_image = cropCenter(save_path, dir_name, M, N);

%  dir_name = 'F:\ÊÓÆµ²âÊÔ\ÊÓÆµ¿â 4.1\';%µÚ5Ö¡->·Ö¿é£¨28*28£©->±£´æÔÚÔ­Â·¾¶
%  disk_path = 'E:';
%  videoClipsAndPictureClips(disk_path, dir_name );

num = 1;
stype = 'bmp';
 dir_name = 'F:\ÊÓÆµ²âÊÔ\ÊÓÆµ¿â 4.1\';
 save_path = 'F:\ÊÓÆµ²âÊÔ\ÊÓÆµÖ¡\µÚÒ»Ö¡\';
videoClips(save_path, dir_name, num, stype);

% disk_path = 'D:';
% dir_name = 'F:\ÊÓÆµ²âÊÔ\ÊÓÆµ¿â 4.1\';
% image_width = 40;
% image_height = 40;
% stride = 50;
% image_stype = 'jpg';
% videoClipsAndPictureClips(disk_path, dir_name, image_width, image_height, stride, image_stype )

% save_path = 'F:\ÊÓÆµ²âÊÔ\²Ã¼ôÍ¼Æ¬ÊÓÆµ\';
% dir_name = 'F:\ÊÓÆµ²âÊÔ\µÚ5Ö¡\';
% avi_name = 'diÎåÖ¡';
% pictureToVideo(save_path, dir_name, avi_name);

save_path = 'F:\ÊÓÆµ²âÊÔ\Í¼Æ¬²Ã¼ô\²Ã¼ôÍ¼Æ¬90\';
dir_name = 'F:\ÊÓÆµ²âÊÔ\µÚ5Ö¡\';
M = 90;
N = 90;
cropCenter(save_path,dir_name, M, N)





