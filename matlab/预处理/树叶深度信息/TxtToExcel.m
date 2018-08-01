%% 把txt文件转化到excel中
% path = 'C:\Users\LiTao\Desktop\新建文本文档.txt';
% fid = fopen(path, 'r');
% k = 1;
% data = [];
% rowStr = cell(1, 20);
% while ~feof(fid)
%     tline = fgetl(fid);
%     if ~isempty(tline)
%         [m, n] = find(tline == ' '); 
%         str = tline(1:n(1));
%         rowStr(k, 1) = mat2cell(str);
%         col = 2;       
%         for i = 1 : length(n(1, :)) - 1
%             str = tline(n(i):n(i+1));
%             [~, pos] = find(str == ' ');
%             if strcmp(str, ' ') ~= 1 && strcmp(str, '  ') ~= 1                
%                 rowStr(k, col) = mat2cell(str);       
%                 col = col + 1;
%             end
%         end
%         str = tline(n(length(n(1, :))):length(tline));
%         rowStr(k, col) = mat2cell(str);
%         k = k + 1;
%         data = [data; rowStr];
%     end
%    
% end
% xlswrite(path, data);
% fclose(fid);