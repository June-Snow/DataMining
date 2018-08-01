function ELOiterater(path, len)
%% ����ELO���ŵ�������
 %path:����·����len:���ݸ���

%% ��ʼ������
flag = 0;
for i = 10 : -1 : 1
    excelPath = strcat(path, '����', num2str(i), '.xls');
    if exist(excelPath, 'file')
        [strData, strName] = xlsread(excelPath);
        strName = strData(:, 1);
        strData = strData(:, 2);
        flag = 1;
        break;
    end
end

if flag == 0
    strName = rand(len, 1)*len*10;
    strData = zeros(len, 1);
    strData(:, 1) = 1600;
end

len = length(strData(:, 1));
if len >= 2400
    k = 16;
elseif 2100 < len && len < 2400
    k = 24;    
else
    k = 32;
end

strIndex = zeros(len, 1);

iniInfo.path = path;
iniInfo.strName = strName;
iniInfo.strData = strData;
iniInfo.strIndex = strIndex;
iniInfo.pos = [0; 0];
iniInfo.K = k;

%% 
for i = 1 : len
    [iniInfo] = SelectComparePos(iniInfo);    
    RA = iniInfo.strData(iniInfo.pos(1, 1));
    RB = iniInfo.strData(iniInfo.pos(2, 1));

    if abs(iniInfo.strName(iniInfo.pos(1, 1)) - iniInfo.strName(iniInfo.pos(2, 1))) < 100
        randNum = rand(1)*10;
        if ceil(randNum/3) == 1;
            SA = 1;
            SB = 0;
        elseif ceil(randNum/3) == 2;
            SA = 0;
            SB = 1;
        else
            SA = 0.5;
            SB = 0.5;
        end

    elseif iniInfo.strName(iniInfo.pos(1, 1)) < iniInfo.strName(iniInfo.pos(2, 1))
        SA = 0;
        SB = 1;
    elseif iniInfo.strName(iniInfo.pos(1, 1)) > iniInfo.strName(iniInfo.pos(2, 1))
        SA = 1;
        SB = 0;
    end
        
    [newRA, newRB] = ELORatingSystem(RA, RB, SA, SB, iniInfo.K);
    iniInfo.strData(iniInfo.pos(1, 1)) = newRA;
    iniInfo.strData(iniInfo.pos(2, 1)) = newRB;

    num = sum(iniInfo.strIndex == 0);
    if num == 0
        for j = 1 : 10
            excelPath = strcat(iniInfo.path, '����', num2str(j), '.xls');
            if ~exist(excelPath, 'file')
                data = cell(len, 2);
                data(:, 1) = num2cell(iniInfo.strName(:, 1));
                data(:, 2) = num2cell(iniInfo.strData(:, 1));
                xlswrite(excelPath, data);
                break;
            end
        end
    end
end

end


function [iniInfo] = SelectComparePos(iniInfo)
%% ѡȡ�����Ƚ���
%���ݷ�������
[iniInfo.strData(:, 1), index] = sortrows(iniInfo.strData(:, 1));
iniInfo.strName = iniInfo.strName(index, 1);
iniInfo.strIndex = iniInfo.strIndex(index, 1);

%ѡ��û�б�ѡ�е�ͼƬ
len = length(iniInfo.strName(:, 1));
curPos = ceil(rand(1)*len);
while iniInfo.strIndex(curPos, 1) == 1
    curPos = ceil(rand(1)*len);        
end
iniInfo.strIndex(curPos, 1) = 1;
RA = iniInfo.strData(curPos, 1);

randPos = [];
i = curPos + 1;
while  i <= len
    RB = iniInfo.strData(i, 1);
    EA = 1/(1+10.^((RA - RB)/400));
    if abs(EA-0.5) <= 0.02
        randPos = [randPos, i];
    else
        break;
    end
    i = i + 1;
end

i = curPos - 1;
while 1 <= i
    RB = iniInfo.strData(i, 1);
    EA = 1/(1+10.^((RA - RB)/400));
    if abs(EA-0.5) <= 0.02
        randPos = [randPos, i];
    else
        break;
    end
    i = i - 1;
end

if isempty(randPos)
    [r, ~] = find(iniInfo.strIndex(:, 1) == 0);
    pos = curPos;
    if ~isempty(r)
        pos = r(1);
    end
else
    len = length(randPos);
    pos = ceil(rand(1)*len);
    pos = randPos(pos);
end
iniInfo.pos(1,1) = curPos;
iniInfo.pos(2,1) = pos;

end


function [newRA, newRB] = ELORatingSystem(RA, RB, SA, SB, K)
%% ����ELO���޷�
%RA,RB���쳣�ȼ���,EA���Ա�����ƵA����ǵ�����
EA = 1/(1+10.^((RA - RB)/400));
%EB���Ա�����ƵA����ǵ�����
EB = 1 - EA;
%SA����ʾ�������
newRA = RA + K*(SA - EA);
newRB = RB + K*(SB - EB);
end


