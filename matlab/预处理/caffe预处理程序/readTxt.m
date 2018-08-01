
fid = fopen('C:\Users\Serissa\Desktop\train.txt');
context = textscan(fid, '%s');
fclose(fid);
[A] = context{:};
len = length(A);
imageName = [];

path = 'C:\Users\Serissa\Desktop\ky2-20180220\';
img_path_list2 = dir([path,'*.png']);
len2 = length(img_path_list2);
for i = 1 : len2
    file_path2 = strcat(path, img_path_list2(i).name);
    [~, name2, ext] = fileparts(file_path2);
    str = regexp(name2, '_', 'split');
    if strcmp(str{1, 6}, '2018-02-20') == 1
        partName = strcat(str{1, 6},'-', str{1, 7}, '-', str{1, 5});
        imageName = [imageName;partName];
    end
    
end
ss = sort(imageName);

saveTextPath = 'C:\Users\Serissa\Desktop\2018-02-20.txt';
test = fopen(saveTextPath,'wt');

for i =1 : length(ss)
    fprintf(test, ss(i, :));
    fprintf(test, '\n');%\r
end
fclose(test);

for i = 1 : len
    name = A{i, :};
    str = regexp(name, '_', 'split');
    if strcmp(str{1, 6}, '2018-01-23') == 1
        partName = strcat(str{1, 6},'-', str{1, 7}, '-', str{1, 5});
        imageName = [imageName;partName];
    end
    
end
ss = sort(imageName);

saveTextPath = 'C:\Users\Serissa\Desktop\2018-01-23.txt';
test = fopen(saveTextPath,'wt');

for i =1 : length(ss)
    fprintf(test, ss(i, :));
    fprintf(test, '\n');%\r
end
fclose(test);