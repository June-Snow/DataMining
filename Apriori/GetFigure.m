fileshield = 'F:\�ճ�����\��Ҷ�ڵ�\ʵ����\��Ҷ�ڵ�.txt';
files = fopen(fileshield);
faxs = textscan(files, '%s');
lens = length(faxs{1});
celnums = faxs{1};
filenormal = 'F:\�оֵڶ�������ͼƬ����\0019 ��Ҷ�ڵ�.txt';
filen = fopen(filenormal);
faxn = textscan(filen, '%s');
lenn = length(faxn{1});
celnumn = faxn{1};

%testdatas = zeros(lens, 9);
testdatas = zeros(lenn+lens, 9);
for i = 1 : lens
    k = 1;
    num = celnums{i};
    for j = 1 : length(num)
        char = num(j);
        if(char == '1')
            testdatas(i, k) = j;
            k = k + 1;
        end
    end
end
%save testdatas testdatas;
for i = 1 : lenn
    k = 1;
    num = celnumn{i};
    for j = 1 : length(num)
        char = num(j);
        if(char == '1')
            testdatas(lens+i, k) = j;
            k = k + 1;
        end
    end
end

save testdatas testdatas;

