%% ���ͼƬ��ֵ
savePath = 'C:\Users\LiTao\Desktop\�½��ļ��� (3)\���ͼƬ\��ֵͼ\';
path1 = 'C:\Users\LiTao\Desktop\�½��ļ��� (3)\���ͼƬ\ԭͼ\';%�����ϢͼƬ
img_path_list1 = dir([path1,'*.jpg']);
if isempty(img_path_list1);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len1 = length(img_path_list1);

path = 'C:\Users\LiTao\Desktop\�½��ļ��� (3)\����������ļ�\';
excelPath = strcat(path, '����5.xls');
if exist(excelPath, 'file')
    [strData1, strName1] = xlsread(excelPath);
    strData1 = (strData1-min(strData1))/(max(strData1) - min(strData1));
end
len2 = length(strData1);

data = zeros(10, 2);
for i = 1 : len1
    file_path1 = strcat(path1, img_path_list1(i).name);
    [~, name1, ext1] = fileparts(file_path1);
    name2 = name1(1: end-5);
    img = imread(file_path1);
    img(img == 1) = 255;
    for j = 1 : len2
        name = strName1{j};
        name = name(1: end-4);
        if ~isempty(strfind(name, name2))
            num = name(end-1:end);
            num = str2num(num);
            img(img == num) = strData1(j)*218+12;%��ֵ��12-230

        end
    end
    imwrite(img, strcat(savePath, name1, ext1));
    
end