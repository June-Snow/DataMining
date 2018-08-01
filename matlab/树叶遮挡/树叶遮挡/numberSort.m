clear all
clc

root = 'C:\Users\litao\Desktop\Ê÷Ò¶ÕÚµ²¼ì²â\Ê÷Ò¶ÕÚµ².txt';
fileID = fopen(root);
fax = textscan(fileID,'%s');
len = length(fax{1});
num = fax{1};


num = sort(num);
sum = 1;
fid = fopen(strcat('C:\Users\litao\Desktop\Ê÷Ò¶ÕÚµ²¼ì²â\Ê÷Ò¶ÕÚµ²ÅÅÐò½á¹û', '.txt'), 'w');
for i = 2: length(num)
    if (char(num(i - 1)) == char(num(i)));
        sum = sum + 1;        
    else
        fprintf(fid,'%s %d\t',char(num(i - 1)),sum);
        sum = 1;
    end
end
fprintf(fid,'%s %d\t',char(num(length(num))),sum);
fclose(fid);
