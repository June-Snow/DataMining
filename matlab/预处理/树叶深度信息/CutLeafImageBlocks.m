%%
%ѡ��ͼƬ���ض�λ�õ���Ҷ�����ú�ɫ�����ʾ����Ҷָ�Ĳ���ֻ����Ҷ��������ɫ��ƺ
%�Դ���Ϊ�����Ϣ���������ֵ�����


path = 'C:\Users\LiTao\Desktop\�½��ļ��� (4)\';%%ps�ļ�
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(img_path_list);
sourcePath = strcat(path,'Դ�ļ�\');%����ԭʼͼ��ԭʼͼ��ᱣ����ȡͼ��ʱ���µľ��ο�
cutPath = strcat(path,'�����ļ�\');%�����ȡͼ��
mkdir(sourcePath);
mkdir(cutPath);

for i=1 : len
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    if exist(file_path, 'file')
        image = imread(file_path);
        
        batCrop(image, name, ext, sourcePath, cutPath)
    end
end

