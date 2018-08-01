function array = posNegDirection(array, jitter_direc)
%
len = length(array(:, 2));
for i = 1 : len
    cur_direction = array(i, 2);
    if abs(jitter_direc - cur_direction) <= 90
        array(i, 2) = 1;
    else
        array(i, 2) = -1;
    end
end
end