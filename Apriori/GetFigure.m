inputfile = 'F:\日常工作\树叶遮挡\实验结果\树叶遮挡.txt';
file = fopen(inputfile);
fax = textscan(file, '%s');
len = length(fax{1});
celnum = fax{1};
testdata = zeros(len, 9);

for i = 1 : len
    k = 1;
    num = celnum{i};
    for j = 1 : length(num)
        char = num(j);
        if(char == '1')
            testdata(i, k) = j;
            k = k + 1;
        end
    end
end