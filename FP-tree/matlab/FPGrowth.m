function fps = FPGrowth(tree, alpha)
%%
if tree.root == 0
    fps = {};
    return;
end % if tree is empty, then return

if nargin < 2, alpha = []; end

node = tree.root;
headlist = tree.headlist;

% search for branching node
assert(node ~= 0);
child = node.first_child;
while child ~= 0
    if child.next_sibling ~= 0, break; end
    node = child;
    child = node.first_child;
end
brnode = node; % save the branching node

% find frequent itemsets for single prefix path P
if node == tree.root
    idx = 0;
else
    idx = find(headlist.items == brnode.item_name);
end
fps_p = combinatory(headlist.items(1:idx), headlist.counts(1:idx), headlist.refs, idx);
for k=1:length(fps_p)
    fps_p(k).itemset = union(alpha, fps_p(k).itemset);
end

% find frequent itemsets for multi-path Q
fps_q_c = cell(0, 3);
offset = 0; % index for 'fps_q_c'
for j=headlist.size:-1:(idx+1)
    beta = union(alpha, headlist.items(j));
    cnt = headlist.counts(j);
    % construct conditional pattern bases for beta
    cpbases = cell(cnt, 1);
    counts = zeros(cnt, 1);
    refs = cell(1, cnt);
    % TODO: add refs
    node = headlist.heads{j};
    r = 0;
    while node ~= 0
        parent = node.parent;
        if parent ~= brnode
            r = r + 1;
            counts(r) = node.count;
            refs{r} = node.refs; % TODO
            tmpbase = [];
            while parent ~= brnode
                tmpbase = union(tmpbase, parent.item_name);
                parent = parent.parent;
            end
            cpbases{r} = tmpbase;
        end
        node = node.node_link;
    end
    if r ~= 0 % number of conditional pattern bases of beta
        cond_tree = FPTree(cpbases, counts, refs, r); % TODO: add refs
        cond_fps = FPGrowth(cond_tree, beta);
    end
    %%%%%%%%%%%%%%%%%%%%%%
    Equals = false(offset, 1);
    for i=1:offset
        if length(intersect(beta, fps_q_c{i,1})) == length(beta)
            Equals(i) = true;
        end
    end
    I = find(Equals);
    bInc = true;
    for i=1:length(I)
        if fps_q_c{I(i),2} == cnt
            bInc = false;
            break;
        end
    end
    if bInc && r ~= 0
        for i=1:length(cond_fps)
            if cond_fps(i).count == cnt
                bInc = false;
                break;
            end
        end
    end
    k = offset;
    if bInc
        k = k + 1;
        fps_q_c{k,1} = beta; % #ok<AGROW>
        fps_q_c{k,2} = cnt; % #ok<AGROW>
        fps_q_c{k,3} = headlist.refs{j};
    end
    %%%%%%%%%%%%%%%%%%%%
    if r ~= 0
        for i=1:length(cond_fps)
            bInc = true;
            for ii=1:length(I)
                if length(intersect(cond_fps(i).itemset, fps_q_c{I(ii),1})) == length(cond_fps(i).itemset)...
                        && cond_fps(i).count == fps_q_c{I(ii),2}
                    bInc = false;
                    break;
                end
            end
            if bInc
                k = k + 1;
                fps_q_c{k,1} = cond_fps(i).itemset; % #ok<AGROW>
                fps_q_c{k,2} = cond_fps(i).count; % #ok<AGROW>
                fps_q_c{k,3} = cond_fps(i).refs; % #ok<AGROW>
            end
        end
    end
    offset = k;
end
fps_q = cell2struct(fps_q_c, {'itemset', 'count', 'refs'}, 2);

fps = crossproduct(fps_p, fps_q);

end % end of FPGrowth()