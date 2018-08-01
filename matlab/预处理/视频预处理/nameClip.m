function name = nameClip(name_str)
%截取字符串的'('、'_'的前面一部分
index_bracket = strfind(name_str, '(');
index_underline = strfind(name_str, '_');
index_char = strfind(name_str, '-'); 

if isempty(index_bracket)
    index_bracket = 0;
end
if isempty(index_underline)
    index_underline = 0;
end
if isempty(index_char)
    index_char = 0;
end
val = [index_bracket, index_underline, index_char];

flage = zeros(1, 3);
[~, pos] = find(val == 0);
flage(pos)=1;
index_val = val(flage == 0);
index = min(index_val);

if ~isempty(index)
    name = name_str(1 : index(end)-1);    
else
    name = name_str;
end

end