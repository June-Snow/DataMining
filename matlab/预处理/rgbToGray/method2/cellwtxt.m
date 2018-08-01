function  cellwtxt(txtname,celldata)
% 看到不少人都为怎么把元包数组怎么写入txt文件而不知所措，
% 为此写了这个低效率函数。
% 其功能是把元包结构按原来的形式写入txt文件。
% 调用格式 cellwtxt('txtname','celldata')
% 参数解释 ：txtname ----- 存储元包数组的txt文件名,其为字符串，并请正确命名。
%           celldata ----  元包数组。
if nargin ~= 2
    disp('函数调用格式错误')
    return
end
if ~ischar(txtname)
    disp(['txt文件名命名错误，其应为合法的字符串形式的文件名']);
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
