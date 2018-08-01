%%
%ѡ��ͼƬ���ض�λ�õ���Ҷ�����ú�ɫ�����ʾ����Ҷָ�Ĳ���ֻ����Ҷ��������ɫ��ƺ
%�Դ���Ϊ�����Ϣ���������ֵ�����


path = 'F:\caffe-windows-master\data\0909cloth\cnn\train\crop\��ȱ��\';%%ps�ļ�
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(img_path_list);
cutPath = 'F:\caffe-windows-master\data\0909cloth\cnn\train\pos\';%�����ȡͼ��

for i=1 : len
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    if exist(file_path, 'file')
        num = 0;
        image = imread(file_path);
        [M, N, ~] = size(image);
        for j = 1:93:M-93
            for k=1:93:N-93
                if mod(num, 2) ~= 0
                    img = image(j:j+92, k:k+92, :);
                    imwrite(img, strcat(cutPath, name, '_', num2str(j), '_', num2str(k), ext));
                end
                num = num +1;
            end
        end
        %         image3 = imrotate(image, 90);
        %         image4 = imrotate(image, 180);
        %         image5 = imrotate(image, 270);
        %         imwrite(image3, strcat(cutPath, name, '_90', ext));
        %         imwrite(image4, strcat(cutPath, name, '_180', ext));
        %         imwrite(image5, strcat(cutPath, name, '_270', ext));
        %
        %         image1 = image(end:-1:1, :, :);
        %         image2 = image(:, end:-1:1, :);
        %         imwrite(image1, strcat(cutPath, name, '_upDown', ext));
        %         imwrite(image2, strcat(cutPath, name, '_LeftRight', ext));
        %
        %         image3 = imrotate(image1, 90);
        %         image4 = imrotate(image1, 180);
        %         image5 = imrotate(image1, 270);
        %         imwrite(image3, strcat(cutPath, name, '_upDown_90', ext));
        %         imwrite(image4, strcat(cutPath, name, '_upDown_180', ext));
        %         imwrite(image5, strcat(cutPath, name, '_upDown_270', ext));
        %
        %         image3 = imrotate(image2, 90);
        %         image4 = imrotate(image2, 180);
        %         image5 = imrotate(image2, 270);
        %         imwrite(image3, strcat(cutPath, name, '_LeftRight_90', ext));
        %         imwrite(image4, strcat(cutPath, name, '_LeftRight_180', ext));
        %         imwrite(image5, strcat(cutPath, name, '_LeftRight_270', ext));
        
    end
end

