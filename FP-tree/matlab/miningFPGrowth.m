function miningFPGrowth(data, sup)

count = 0;
maxlen = 0;
for i = 1 : length(data)
 if(maxlen < length(data{1,i}))
     maxlen = length(data{1,i});
 end
end
data = data(:);
for i = 1 : length(data)
    val = zeros(1, maxlen);
    val = data{i, :};
    for j = 1 : length(val)
        
        dataToDim1(count + j, 1) = val(1, j);
    end
    count = count + length(val);

end
end