root1 = 'C:\Users\litao\Desktop\Ê÷Ò¶ÕÚµ²¼ì²â\Ê÷Ò¶ÕÚµ²ÓëÕý³£Í¼Æ¬.xlsx';
filewrite = fopen(root1,'w');
root2 = 'C:\Users\litao\Desktop\Ê÷Ò¶ÕÚµ²¼ì²â\Õý³£½á¹ûÅÅÐò.txt';
fileopenright = fopen(root2,'r');
root3 = 'C:\Users\litao\Desktop\Ê÷Ò¶ÕÚµ²¼ì²â\Ê÷Ò¶ÕÚµ²ÅÅÐò½á¹û.txt';
fileopencover = fopen(root3,'r');
A = textscan(fileopenright,'%s%s');
C = textscan(fileopencover,'%s%s');
A = [A{1,1}, A{1,2}];
C = [C{1,1}, C{1,2}];
j = 1;
i = 1;
k = 1;
D = zeros(162,3);
while (j ~= length(A) + 1)&&(i ~= length(C) + 1)
    if (str2num(cell2mat(C(i,1))) > str2num(cell2mat(A(j,1))))
        D(k,1) = str2num(cell2mat(A(j,1)));
        D(k,2) = str2num(cell2mat(A(j,2)));
        j = j + 1;
        k = k + 1;
    elseif(str2num(cell2mat(C(i,1))) < str2num(cell2mat(A(j,1))))
        D(k,1) = str2num(cell2mat(C(i,1)));
        D(k,3) = str2num(cell2mat(C(i,2)));
        i = i + 1;
        k = k + 1;
    else 
        D(k,1) = str2num(cell2mat(A(j,1)));
        D(k,2) = str2num(cell2mat(A(j,2)));
        k = k + 1;
        D(k,1) = str2num(cell2mat(C(i,1)));
        D(k,3) = str2num(cell2mat(C(i,2)));
        j = j + 1;
        i = i + 1;
        k = k + 1;
    end
    
end

while(j ~= length(A) + 1)
    D(k,1) = str2num(cell2mat(A(j,1)));
    D(k,2) = str2num(cell2mat(A(j,2)));
    j = j + 1;
    k = k + 1;
end

while(i ~= length(C) + 1)
    D(k,1) = str2num(cell2mat(C(i,1)));
    D(k,3) = str2num(cell2mat(C(i,2)));
    i = i + 1;
    k = k + 1;
end
    
xlswrite(root1,D,'sheet1','A1:C3')


fclose(fileopenright);
fclose(fileopencover);
fclose(filewrite);