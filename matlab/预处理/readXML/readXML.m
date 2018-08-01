% import javax.xml.xpath.*
% factory = XPathFactory.newInstance;
% xpath = factory.newXPath;
% url1 = xpath.complie('annotation/object/name');
% getnode = url1.evaluate(docNode, XPathConstants.NODE);
clear all;
clc;

originPath = 'E:\CNN-public-data-sets\VOC2012\VOCtrainval_11-May-2012\VOCdevkit\VOC2012\JPEGImages\';

save_path = 'E:\CNN-public-data-sets\VOC2012\VOC2012-classification\';

dir_name = 'E:\CNN-public-data-sets\StanfordDogsDataset\annotation\';

COLS = 224;
ROWS = 224;

file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end


for i = 13858 : length(file_List)
    disp(['Now processing image:', num2str(i)]);
    %%读取图片
    file = file_List{i};
    [pathstr, name, ext] = fileparts(file);
    xmlData = xmlread(file);
    
    IDArray = xmlData.getElementsByTagName('filename');
    imageName = char(IDArray.item(0).getFirstChild.getData);
    
    IDArray = xmlData.getElementsByTagName('name');
    className = char(IDArray.item(0).getFirstChild.getData);
    
    IDArray = xmlData.getElementsByTagName('xmin');
    starCol = char(IDArray.item(0).getFirstChild.getData);
    starCol = str2num(starCol);
    
    IDArray = xmlData.getElementsByTagName('ymin');
    starRow = char(IDArray.item(0).getFirstChild.getData);
    starRow = str2num(starRow);
    
    IDArray = xmlData.getElementsByTagName('xmax');
    endCol = char(IDArray.item(0).getFirstChild.getData);
    endCol = str2num(endCol);
    
    IDArray = xmlData.getElementsByTagName('ymax');
    endRow = char(IDArray.item(0).getFirstChild.getData);
    endRow = str2num(endRow);
    
    file = strrep(file, 'annotation', '224X224');
    img = imread(strcat(file, '.jpg'));
    [M, N, ~] = size(img);
    %     figure;imshow(img);
    partImage = img(starRow+1:endRow, starCol+1:endCol, :);
    %     figure;imshow(partImage);
    [m, n, ~] = size(partImage);
    if m >= ROWS && n >= COLS %截取部分行列都大于 ROWS, COLS
        partImage = imresize(partImage, [ROWS, COLS]);        
        
    elseif m >= ROWS && n < COLS %截取部分行大于 ROWS, 列小于COLS
        if N <= COLS
            partImage = img(starRow+1:endRow, :, :);            
        else
            while((endCol - starCol +1) < COLS)
                if starCol - 1 >0 
                    starCol = starCol - 1;
                end
                if endCol + 1 < N
                    endCol = endCol + 1;
                end
            end
            partImage = img(starRow+1:endRow, starCol+1:endCol, :);
           partImage = imresize(partImage, [ROWS, COLS]);
        end
    elseif m < ROWS && n >= COLS %截取部分行大于 ROWS, 列小于COLS
        if M <= ROWS
            partImage = img(:, starCol+1:endCol, :);            
        else
            while((endRow - starRow +1) < ROWS)
                if starRow - 1 >0 
                    starRow = starRow - 1;
                end
                if endRow + 1 < M
                    endRow = endRow + 1;
                end
            end
            partImage = img(starRow+1:endRow, starCol+1:endCol, :);           
        end
        partImage = imresize(partImage, [ROWS, COLS]);
    else
        partImage = imresize(img, [ROWS, COLS]);
    end
    
    path = strcat(save_path, className, '\');
    if ~exist(path, 'file')
        mkdir(path);
    end
    movefile(strcat(file, '.jpg'), strcat('E:\CNN-public-data-sets\StanfordDogsDataset\ccc\', num2str(i), '.jpg'));
    imwrite(partImage, strcat(file, '.jpg'));
    
    
end








