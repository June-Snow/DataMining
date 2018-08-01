function  cellwtxt(txtname,celldata)
% ���������˶�Ϊ��ô��Ԫ��������ôд��txt�ļ�����֪���룬
% Ϊ��д�������Ч�ʺ�����
% �书���ǰ�Ԫ���ṹ��ԭ������ʽд��txt�ļ���
% ���ø�ʽ cellwtxt('txtname','celldata')
% �������� ��txtname ----- �洢Ԫ�������txt�ļ���,��Ϊ�ַ�����������ȷ������
%           celldata ----  Ԫ�����顣
if nargin ~= 2
    disp('�������ø�ʽ����')
    return
end
if ~ischar(txtname)
    disp(['txt�ļ�������������ӦΪ�Ϸ����ַ�����ʽ���ļ���']);
    return
end
ID = fopen([txtname,'.txt'],'w');
[m,n] = size(celldata);

%load('z_mos.mat');

for i = 1 : m
    for k = 1 : n
        [rows,col] = size(celldata{i,k});
        if rows > 1
            for j = 1 : rows
                fprintf(ID,'%s\t',celldata{i,k}(j,:));
                fprintf(ID,'\n');
            end
        else
           % fprintf(ID,'%s\t',num2str(z_mos(i)));
            fprintf(ID,'%s\t',celldata{i,k});
            fprintf(ID,'\n');
        end   
    end
    fprintf(ID,'\r\n');
end

fclose(ID);
