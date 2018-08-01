function [jitter_direc, array] = derction(array)
%把360度分成8个区域，把每个区域中出现的次数进行统计，存入对应的1行8列的数组中
jitter_direc = 0;
len = length(array(:, 2));
direc_matrix = zeros(1, 8);
for i = 1 : len
    if array(i, 1) ~= 0
        val = fix(array(i, 2)/45);
        direc_matrix(1, val+1) = direc_matrix(1, val+1) + 1;
    end
end

%求出抖动的方向，把1行8列的数组看成是一个首位相连的队列，相邻的4块作为一组，两组相减最小
all_sum = sum(direc_matrix);
Min_diff_direc = all_sum;
for i = 1 : 4
    part_sum = 0;
    for j = 1 : 4
        part_sum = part_sum + direc_matrix(1, i + j - 1);
    end
    other_sum = abs(part_sum - (all_sum - part_sum));
    mid_sum = direc_matrix(1, i + 1) + direc_matrix(1, i + 2);
    margin_sum = direc_matrix(1, i) + direc_matrix(1, i + 3);   
    if (other_sum < Min_diff_direc) && (mid_sum >margin_sum)  %mid_sum >margin_sum保证方向的准确性
        Min_diff_direc = other_sum;
        jitter_direc = (i+1)*45;
    end      
end


for i = 1 : len
    cur_direction = array(i, 2);
    if abs(jitter_direc - cur_direction) <= 90
        array(i, 2) = 1;
    else
        array(i, 2) = -1;
    end
end


end