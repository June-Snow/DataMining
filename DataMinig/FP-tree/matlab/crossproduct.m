function fps = crossproduct(fps_p, fps_q)
%%
m = length(fps_p); n = length(fps_q);
mn = m * n;
fps_c = cell(mn, 3);
if m > 0 && n > 0
    for i=1:m
        for j=1:n
            k = (i-1) * n + j;
            refs = intersect(fps_p(i).refs, fps_q(j).refs);
            fps_c{k,1} = union(fps_p(i).itemset, fps_q(j).itemset);
%             fps_c{k,2} = min(fps_p(i).count,fps_q(j).count);
            fps_c{k,2} = length(refs);
            fps_c{k,3} = refs;
        end
    end
    k1 = 0;
    new_fps_p = cell2struct(cell(0,3), {'itemset', 'count', 'refs'}, 2);
    for i=1:m
        bKeep = true;
        for j=1:n
            k = (i-1) * n + j;
            if fps_p(i).count == fps_c{k,2}
                bKeep = false;
                break;
            end
        end
        if bKeep
            k1 = k1 + 1;
            new_fps_p(k1) = fps_p(i); % #ok<AGROW>
        end
    end
    k1 = 0;
    new_fps_q = cell2struct(cell(0,3), {'itemset', 'count', 'refs'}, 2);
    for j=1:n
        bKeep = true;
        for i=1:m
            k = (i-1) * n + j;
            if fps_q(j).count == fps_c{k,2}
                bKeep = false;
                break;
            end
        end
        if bKeep
            k1 = k1 + 1;
            new_fps_q(k1) = fps_q(j); % #ok<AGROW>
        end
    end
else
    new_fps_p = fps_p;
    new_fps_q = fps_q;
end
fps_p_q = cell2struct(fps_c, {'itemset', 'count', 'refs'}, 2);
m = length(new_fps_p); n = length(new_fps_q);
fps = cell2struct(cell(m + n + mn, 3), {'itemset', 'count', 'refs'}, 2);

for i=1:m
    fps(i) = new_fps_p(i);
end
for i=1:n
    fps(m+i) = new_fps_q(i);
end
for i=1:mn
    fps(m+n+i) = fps_p_q(i);
end

end % end of crossproduct()