%% 根据打分结果，对图片进行重新命名，图片名就是归一化后的分数
clear all;
clc;
imgPath = 'C:\Users\Serissa\Desktop\树叶遮挡图片\';
savePath = 'C:\Users\Serissa\Desktop\树叶遮挡排序图片\';
textPath = 'C:\Users\Serissa\Desktop\树叶遮挡图片\树叶遮挡图片对应分数.xlsx';
[imgData, imgName] = xlsread(textPath);
len = length(imgData);
[imgData, index] = sort(imgData);
imgName(:) = imgName(index);
numData = cell(len, 1);
for i =1 : len
    str = num2str(imgData(i, 1));
    lenChar = length(str);
    if lenChar >= 6
        str = str(1:6);
    else
        mun = 6 - lenChar;
        switch mun
            case 1
                str = strcat(str, '0');
            case 2
                str = strcat(str, '00');
            case 3
                str = strcat(str, '000');
            case 4
                str = strcat(str, '0000');
            case 5
                str = strcat(str, '0000');
        end
    end
    numData{i, 1} = str;
end
[numData, index] = sortrows(numData, 1);
imgName(:) = imgName(index);
%图片以分数命名
for i = 1 : len - 1
    k = 1;
    for j = i + 1 : len
        if strcmp(numData{i, 1}, numData{j, 1}) == 1
            numData{j, 1} = strcat(num2str(str2num(numData{j, 1}) + 0.0001*k));
            k = k + 1;
        end
    end    
end

for i = 1 : len
    name1 = imgName{i, 1};
    name1 = strrep(name1, 'avi', 'jpg');
    name2 = numData{i, 1};
    sourcePath = strcat(imgPath,name1);
    if exist(sourcePath, 'file')
        copyfile(sourcePath, strcat(savePath, name2, '.jpg'));
    end
end


% len = length(imgInf(:, 1));
% imgData = cell(len, 2);
% valNum = zeros(len, 1);
% index = [];
% % imgInf = sortrows(imgInf, 1);
% 
% for i = 1 : len
% %     if i < len
% %         name1 = imgInf{i, 1};
% %         name2 = imgInf{i+1, 1};
% %         if strcmp(name1, name2) == 1
% %             %index = [index; i+1];
% %         end
% %     end
%     name1 = imgInf{i,1};
%      imgData{i, 1} = name1;
%     name1 = strrep(name1, 'avi', 'jpg');
%     sourcePath = strcat(imgPath,name1);
%     if 2 ~= exist(sourcePath, 'file')
%         %index = [index; i];
%     else
%        %copyfile(sourcePath, strcat(savePath, name1));
%     end
%     val = imgInf{i,2};
%     val = str2double(val);
%     valNum(i, 1) = val;
% end
% valMin = min(valNum);
% valMax = max(valNum);
% imgData(index, :) = [];
% valNum(index, :) = [];
% len = length(valNum);
% for i = 1 : len
%     val = 1 - (valNum(i, 1) - valMin)/(valMax - valMin);%（归一到0 1 之间）
%     %val = 0.1 + (valNum(i, 1) - valMin)/(valMax - valMin)*(0.9 - 0.1);%（归一到0.1-0.9之间）
%     imgData{i, 2} = round(val*1000000);
% %     imgData{i, 2} = val;
% end
% %xlswrite(strcat(imgPath, '树叶遮挡图片对应分数.xlsx'), imgData, 'Sheet1');
% 
% %图片以分数命名
% imgData = sortrows(imgData, 2);%防止重名
% for i = 1 : len - 1
%     if imgData{i, 2} == imgData{i+1, 2}
%         imgData{i+1, 2} = imgData{i+1, 2} + 1;
%     end
% end
% for i = 1 : len
%     name1 = imgData{i, 1};
%     name1 = strrep(name1, 'avi', 'jpg');
%     name2 = num2str(imgData{i, 2});
%     sourcePath = strcat(imgPath,name1);
%     if exist(sourcePath, 'file')
%         copyfile(sourcePath, strcat(savePath, name2, '.jpg'), 'f');
%     end
% end






