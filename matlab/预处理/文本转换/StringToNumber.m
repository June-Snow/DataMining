
fid = fopen('C:\Users\litao\Desktop\��Ҷ�ڵ���ע\��Ƶ5.0b��Ҷ�ڵ�66.txt', 'r');
A = textscan(fid, '%s');
fidw = fopen('E:\��Ƶ�� 5.0\��Ƶ�� 5.0b\��Ƶ5.0b��Ҷ�ڵ�66.txt', 'wt');

str = A{:, 1};
B = zeros(1,36);
n236 = 0;
n23 = 0;
n26 = 0;
n36 = 0;
for i = 1 : length(str)
    count = 0;
    num = str{i, 1};
    len = length(num);
    for j = 1 : length(num)
        val = num(j);
        if(strcmp(val, '1') ~= 0)
%            B(1, j) = B(1, j) + 1;
             count = count + 1;
        end
    end
    if count ~= 0
        fprintf(fidw, '%s', num);
    end
    fprintf(fidw, '\t');
% if((str2num(num(2)) == 1)&&(str2num(num(3)) == 1)&&(str2num(num(6)) == 1))
%     n236 = n236 + 1;
% end
% if((str2num(num(2)) == 1)&&(str2num(num(3)) == 1))
%     n23 = n23 + 1;
% end
% if((str2num(num(3)) == 1)&&(str2num(num(6)) == 1))
%     n36 = n36 + 1;
% end
% if((str2num(num(2)) == 1)&&(str2num(num(6)) == 1))
%     n26 = n26 + 1;
% end
end




c = 0;
