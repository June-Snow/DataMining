function sroccNum = ELORatingSROOC(path)
%% 
sroccNum = zeros(10, 1);
for i = 10 : -1 : 2
    excelPath = strcat(path, '�ڵ�����', num2str(i), '.xls');
    if exist(excelPath, 'file')
        [strData1, strName1] = xlsread(excelPath);
%         strName1 = strData1(:, 1);
%         strData1 = strData1(:, 2);
        index1 = SortStr(strData1, strName1);
        excelPath = strcat(path, '�ڵ�����', num2str(i-1), '.xls');
        [strData2, strName2] = xlsread(excelPath);
%         strName2 = strData2(:, 1);
%         strData2 = strData2(:, 2);
        index2 = SortStr(strData2, strName2);
        len = length(index1);
        srocc = 1 - 6*(sum((index1 - index2).^2))/(len * (len.^2 - 1));
        sroccNum(i-1, 1) = srocc;
    end
end

end

function index = SortStr(strData, strName)
%% ���Ȱ����ֶԷ����������򣬵õ����ֶ�Ӧ����ţ�Ȼ��Է����������������������������ֶ�Ӧ�����

[strName, index] = sortrows(strName);
strData = strData(index, 1);
[strData, index] = sortrows(strData);

end