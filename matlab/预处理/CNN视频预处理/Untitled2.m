%%
textPath = 'C:\Users\litao\Desktop\树叶遮挡图片\tb_leafocclusion.txt';
[imgData] = importdata(textPath);
len = length(imgData(:, 1));
dataStr = cell(len, 2);
valNum = zeros(len, 1);
for i = 1 : len
    imgStr = imgData{i,1};
    pos =strfind(imgStr,'"');
    dataStr{i, 1} = imgStr(single(pos(1)+1) : single(pos(2))-1);
    dataStr{i, 2} = imgStr(single(pos(3))+1 : single(pos(4))-1);
end
dataStr = sortrows(dataStr, 1);

dir_name = 'C:\Users\litao\Desktop\树叶遮挡图片\';
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('设定的文件夹内没有任何视频，请重新检查...')
end
imgName = cell(length(file_List), 1);
for i = 1 : length(file_List)
    %%读取
    img_path = file_List{i};
    [pathstr, name, ext] = fileparts(img_path);
    if strcmp(ext, '.jpg') 
      imgName{i, 1} = [name, ext];
    end
end

if length(dataStr(:, 1)) ~= length(imgName(:, 1))
    i1 = 1;
    i2 = 1;
    while 1
        if i1 ~= length(dataStr(:, 1)) && i2 ~= length(imgName(:, 1))
            if strcmp(dataStr{i1, 1}, imgName{i2, 1})
                i1 = i1 + 1;
                i2 = i2 + 1;
            else
                dataStr{i1, 2} = [];
                i1 = i1 + 1;
            end
        else
            break;
         end   
    end
end
%index = find(dataStr{:, 2} == []);
index = [];
for i = 1 : length(dataStr(:,1))
    str = dataStr{i, 2};
    if isempty(str)
        index = [index, i];
    end
end
dataStr(index',:) = [];
saveTextPath = 'C:\Users\litao\Desktop\树叶遮挡图片\leaf.txt';
fp = fopen(saveTextPath,'wt');
for i =1 : length(dataStr(:, 1))
    fprintf(fp, '%s%s\r',dataStr{i,:});
end
fclose(fp);





