%% ����ͼƬɾ��excel�е�����
% path = 'E:\leafOcclusion\b-Part2\';
% excelPath = strcat(path, 'matlab240Predict_result.xlsx');
% if exist(excelPath, 'file')
%     [strData1, strName1] = xlsread(excelPath);
%     strData1 = strData1(:, 3);
% end
% 
% path1 = 'E:\leafOcclusion\b-Part2-1080p\';
% img_path1 = dir([path1,'*.jpg']);
% if isempty(img_path1);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len1 = length(img_path1);
% 
% data = cell(len1, 2);
% k = 1;
% for i=1 : len1
%     file_path1 = strcat(path1, img_path1(i).name);
%     [~, name1, ext1] = fileparts(file_path1);
%     data{k, 1} = strcat(name1, '.jpg');
%     num = 0;
%     for j = 1 : length(strData1)        
%         name2 = strName1{j};
%         name2 = name2(1:end-4);
% %         if ~isempty(strfind(name1, name2))% && num < strData1(j)      
% %            data(k, 2) = num2cell(strData1(j));
% %            num = strData1(j);
% %         end
%         if strcmp(name1, name2) == 1
%             data(k, 2) = num2cell(strData1(j));
%             break;
%         end
%     end
%     k = k + 1;
% end
% excelPath = strcat(path1, '�ڵ�����.xls');
% xlswrite(excelPath, data);

%% �ļ�ɾ��
% path1 = 'H:\leaf-cnn\classification\deeplearning\leafDepth\caffeTrain\20161216\2017-360x640\normal\';
% img_path1 = dir([path1,'*.jpg']);
% if isempty(img_path1);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len1 = length(img_path1);
% 
% savePath = 'C:\Users\LiTao\Desktop\�½��ļ��� (5)\';
% 
% for i=1 : len1
%     file_path1 = strcat(path1, img_path1(i).name);
%     [~, name, ext] = fileparts(file_path1);
%     if mod(i, 5) ~= 0
%         movefile(strcat(path1, name, ext), strcat(savePath, name, ext));
%     end
%     
% end

%% 
% savePath = 'C:\Users\LiTao\Desktop\�½��ļ���\';
% path = 'C:\Users\LiTao\Desktop\273\';
% img_path_list = dir([path,'*.jpg']);
% if isempty(img_path_list);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len = length(img_path_list);
% strName = cell(len, 1);
% for i=1 : len
%     file_path = strcat(path, img_path_list(i).name);
%     [~, name, ext] = fileparts(file_path);
%     strName{i, 1} = (strcat(name, ext));
% end
% [data1, num] = xlsread('E:\leafOcclusion\b-Part2\matlab240Predict_result.xlsx');
% len1 = length(data1);
% pos = zeros(len, 1);
% j = 1;
% for i = 1 : len
%     leafCount = 0;
%     arCount = 0;    
%     for k = 1 : len1
%         if strcmp(num(k, 1), strName(i, 1)) == 1
%             pos(j) = k;
%             j = j + 1;
% %             if k > 0 && k <= 500
% %                 copyfile(strcat(path, strName{i, 1}), strcat(savePath, strName{i, 1}));
% %             end
%             break;
%         end
%     end
% end
% pos = sort(pos);

%% ���ļ������ҳ���ͬ���ļ�
% path = 'C:\Users\LiTao\Desktop\273\';
% img_path_list = dir([path,'*.jpg']);
% if isempty(img_path_list);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len = length(img_path_list);
% path2 = 'E:\leafOcclusion\b-Part2-1080p\';
% savePath = 'C:\Users\LiTao\Desktop\�½��ļ��� (3)\';
% for i=1 : len
%     file_path = strcat(path, img_path_list(i).name);
%     [~, name, ext] = fileparts(file_path);
%     name = name(1:end);
%     path3 = strcat(path2, name, ext);
%     if exist(path3, 'file')
%         copyfile(path3, strcat(savePath, name, ext));
%     end
% end


%% ���ļ������ҳ�ǰ����������ͬ���ļ�
% path1 = 'H:\leaf-cnn\��Ҷ�����Ϣ\���ͼƬ\��ֵͼ\';
% img_path1 = dir([path1,'*.jpg']);
% if isempty(img_path1);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len1 = length(img_path1);
% 
% path2 = 'H:\leaf-cnn\classification\deeplearning\leafDepth\caffeTrain\20161216\2017-360x640\360x640\';
% img_path2 = dir([path2,'*.jpg']);
% if isempty(img_path2);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len2 = length(img_path2);
% 
% savePath = 'H:\leaf-cnn\classification\deeplearning\leafDepth\caffeTrain\20161216\2017-360x640\�½��ļ���\';
% 
% for i=1 : len1
%     file_path1 = strcat(path1, img_path1(i).name);
%     [~, name1, ext1] = fileparts(file_path1);
%     for j = 1 : len2
%         file_path2 = strcat(path2, img_path2(j).name);
%         [~, name2, ext2] = fileparts(file_path2);
%         if ~isempty(strfind(name2, name1)) 
%             copyfile(file_path2, strcat(savePath, name2, ext2));
%            
%         end
%     end
% end