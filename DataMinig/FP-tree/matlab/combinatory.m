function fps = combinatory(items, counts, refs, n)
%%
% only find maximum frequent patterns
count = 0; num = 0;
ends = zeros(n,1);
for j=n:-1:1
    if counts(j) > count
        count = counts(j);
        num = num + 1;
        ends(num) = j;
    end
end
fps_c = cell(num, 3);
for i=1:num
    eds = ends(num+1-i);
    fps_c{i,1} = items(1:eds);
    fps_c{i,2} = counts(eds);
    fps_c{i,3} = refs{eds};
end
fps = cell2struct(fps_c, {'itemset', 'count', 'refs'}, 2);
end % end of combinatory()