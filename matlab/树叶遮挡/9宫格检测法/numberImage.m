%% ����Ҷ�ڵ��ַ���ת����ͼƬ��ʾ����
clear all;
clc;
root = 'F:\�ճ�����\��Ҷ�ڵ�\��Ҷ�ڵ�������.txt';
fileID = fopen(root);
A = textscan(fileID,'%s %s');
[C indx]= sort(A{2});
B = cell(106,1);
D = A{1};
for i = 1:length(indx)
    B(i) = D(i);
end
fclose(fileID);
img = zeros(90,90,3);
zeros(1:90,1:90,1:3)=255;
for i = 1 :length(B)    
    num = num2str(B{i});
    for j = 1 : length(num)
        if num(j) == '1'
            num1= (mod((j-1),3)*30 + 1);
            num2 = ((mod((j -1),3)+1)*30);
            num3 = (floor((j-1)/3)*30 +1);
            num4 = floor((j+ 2)/3)*30;
            zeros((floor((j-1)/3)*30 +1):(floor((j+2)/3)*30),(mod((j-1),3)*30 + 1):((mod((j -1),3)+1)*30),1)=0;
            zeros((floor((j-1)/3)*30 +1):(floor((j+2)/3)*30),(mod((j-1),3)*30 + 1):((mod((j -1),3)+1)*30),3)=0;
        end
    end
    h = figure;
    imshow(zeros);
    title(C(i));
    %imwrite(h,strcat('C:\Users\litao\Desktop\�½��ļ���\',B{i},'.jpg'))
    zeros(1:90,1:90,1:3)=255;
end




