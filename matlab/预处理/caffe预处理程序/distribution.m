%% 把一天内的记录体重数值，对应于24小时，分布展开
function distribution(hour_minute_second, weights, save)
[hour_minute_second, weights] = deleteDuplicateData(hour_minute_second, weights);
dist_weight = [];
weight = weights(1);
i = 1;
for h = 0 : 23
    for m = 0 : 59
        for s = 0 : 59            
            hms = hour_minute_second(i, :);
            str = strcat(formatConversion(h), '-', formatConversion(m), '-', formatConversion(s));
            if compare(hms, str) == 0
                weight = weights(i);
                dist_weight = [dist_weight, weight];                
                i = i + 1;               
                if i > length(weights(1, :))
                    i = length(weights(:, 1));
                end
            elseif compare(hms, str) > 0
                dist_weight = [dist_weight, weight];                
            elseif compare(hms, str) < 0
                disp('data error');
                dist_weight = [dist_weight, weight];      
            end
        end
    end
end

plot(1:length(dist_weight), dist_weight);
ylim([130 170])
set(gca,'XTick',0:ceil(length(dist_weight)/24):length(dist_weight));
set(gca,'XTickLabel',(0:1:23));
saveas(gcf, save);
end

function str = formatConversion(num)
str = num2str(num);
if length(str) == 1
    str = strcat('0', str);
end
end

function pos = compare(str1, str2)
k=min(length(str1),length(str2));
for n = 1 : k
    if(str1(n) > str2(n))
        pos = 1;break;
    elseif (str1(n) == str2(n))
        pos = 0;
    else
        pos = -1;break;
    end
end

end

function [hms, weihgt] = deleteDuplicateData(hour_minute_second, weights)
hms = [];
weihgt = [];
i = 1;
len = length(weights(1, :));
while(i < len-1)
    hms = [hms; hour_minute_second(i, :)];
    weihgt = [weihgt, weights(i)];
    for j = i+1 : len
        if compare(hour_minute_second(i, :), hour_minute_second(j, :)) ~= 0
            i = j;
            break;
        end
    end
end

end

