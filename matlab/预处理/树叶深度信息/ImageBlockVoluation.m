%% �Ծ���ELO�����ͼ���ͼ��鸳ֵ
%Excel�б������ԭʼͼ�����ֺͶ�Ӧ��ELO����
%����excel�еķ�������ͬ�����Ϣ��ͼ��鸳ֵ

% path = 'H:\leaf-cnn\classification\deeplearning\leafDepth\leafDeep\20161216\';
% excelPath = strcat(path, '����5.xls');
% if exist(excelPath, 'file')
%     [strData1, strName1] = xlsread(excelPath);
%     %strData1 = strData1(:, );
% end
% 
% path = 'H:\leaf-cnn\classification\deeplearning\leafDepth\caffeTrain\20161216\2017-360x640\360x640\';
% img_path_list = dir([path,'*.jpg']);
% if isempty(img_path_list);
%     error('�趨���ļ�����û���κ���Ƶ�������¼��...')
% end
% len = length(img_path_list);
% data = cell(len, 2);
% k = 1;
% for i=1 : len
%     file_path = strcat(path, img_path_list(i).name);
%     [~, name, ext] = fileparts(file_path);
%     if exist(file_path, 'file')           
%         
%         for j = 1 : length(strData1)
%             sss = strName1{j, 1};
%             sss = sss(1 : end-4);
%             if ~isempty(strfind(name, sss)) 
%                 data(k, 2) = num2cell(strData1(j, 1));
%                 data{k, 1} = strcat(name, ext); 
%                 k = k + 1;
%                 break;
%             end
%         end
%     end
% end
% 
% % path1 = 'C:\Users\LiTao\Desktop\�½��ļ��� (2)\';
% % for i = 1 : len
% %     if isempty(data{i, 2})         
% %         movefile(strcat(path, data{i, 1}), strcat(path1, data{i, 1}));
% %     end
% % end
% 
% excelPath = strcat(path, 'ѵ������.xls');
% xlswrite(excelPath, data);



path = 'H:\leaf-cnn\classification\deeplearning\leafDepth\caffeTrain\20161216\2017-360x640\360x640\';
excelPath = strcat(path, '����.xlsx');
if exist(excelPath, 'file')
    [strData1, strName1] = xlsread(excelPath);
end

path = 'H:\leaf-cnn\classification\deeplearning\leafDepth\caffeTrain\20161216\2017-360x640\360x640\';
img_path_list = dir([path,'*.jpg']);
if isempty(img_path_list);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end
len = length(img_path_list);
data = cell(len, 2);
k = 1;
for i=1 : len
    file_path = strcat(path, img_path_list(i).name);
    [~, name, ext] = fileparts(file_path);
    if exist(file_path, 'file')           
        
        for j = 1 : length(strData1)
            sss = strName1{j, 1};
            sss = sss(1 : end-4);
            if ~isempty(strfind(name, sss)) 
                data(k, 2) = num2cell(strData1(j, 1)*0.95);
                data{k, 1} = strcat(name, ext); 
                k = k + 1;
                break;
            end
        end
    end
end

% path1 = 'C:\Users\LiTao\Desktop\�½��ļ��� (2)\';
% for i = 1 : len
%     if isempty(data{i, 2})
%         
%         movefile(strcat(path, data{i, 1}), strcat(path1, data{i, 1}));
%     end
% end

excelPath = strcat(path, 'ѵ������.xls');
xlswrite(excelPath, data);





