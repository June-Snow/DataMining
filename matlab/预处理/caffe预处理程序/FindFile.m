%% ��������ͼ���ԭʼͼ�����ҳ���Ӧ��ͼ��
% saveDir = 'J:\��Ҷ\ԭʼͼƬ��ǩ\';%����Ŀ¼
% dir_name1 = 'J:\��Ҷ\ԭʼͼƬ��ǩ\';%Ŀ���ļ�
% dir_name2 = 'J:\��Ҷ\train\';%ԭʼĿ���ļ�
% file_name = dir([dir_name1, '*.jpg']);
% for i = 1 : length(file_name)
%     %%��ȡͼƬ
%     file = strcat(dir_name1, file_name(i).name);
%     [~, image_name, ext] = fileparts(file);
%     img = imread(file);
%     imwrite(img, strcat(saveDir, image_name, '.png'));
% %     
% %     if(exist(strcat(dir_name2, image_name, '.jpg'),'file'))
% %         copyfile(strcat(dir_name2, image_name, '.jpg'), strcat(saveDir, image_name, '.jpg'));
% %     end
% end


%% ��������ͼ���ԭʼͼ�����ҳ���Ӧ��ͼ��
saveDir = 'G:\caffe-windows-master\python\lsingModelData\samples - 1\';%����Ŀ¼
dir_name = 'G:\caffe-windows-master\python\lsingModelData\samples\';%ԭʼĿ���ļ�
file_name = dir([dir_name, '*.jpg']);
for i = 1 : length(file_name)
    %%��ȡͼƬ
    file = strcat(dir_name, file_name(i).name);
    [~, image_name, ext] = fileparts(file);
    img = imread(file);
    img = imresize(img, [227, 227]);
    imwrite(img, strcat(saveDir, image_name, '.jpg'));
%     
%     if(exist(strcat(dir_name2, image_name, '.jpg'),'file'))
%         copyfile(strcat(dir_name2, image_name, '.jpg'), strcat(saveDir, image_name, '.jpg'));
%     end
end