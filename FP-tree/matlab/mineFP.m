function fps = mineFP(data, sup)
% MINEFP Mining frequent item-sets using FP-Growth algorithm
%     FPS = minFP(DATA, SUP) mines frequent item-sets which occur at least
%     SUP times from DATA. 
%     Reference: Han, J., J. Pei, et al. (2000). Mining frequent patterns
%     without candidate generation, New York, NY, USA.
%     See also MALLOC, @POINTER\POINTER by Nikolai Yu. Zolotykh, 2004
%
%     author: Hongshan Jiang
%     email: jhs03 AT mails.thu.edu.cn
%     date: Aug. 1, 2009
%
%     Examples:
%         data = {[1 2 4 5 7], [2 3 4 5 6 7 8], [1 3 4 6 7]};
%         fps = mineFP(data, 3);
%

global xi; global ni;
xi = sup;
nt = length(data);
ni = 0;
for i=1:nt
    max_val = max(data{i});
    if max_val > ni
        ni = max_val;
    end
end

refs = cell(1, nt);
for i=1:nt, refs{i} = i; end

tree = FPTree(data, ones(nt,1), refs, nt); % construct FP-tree

fps = FPGrowth(tree);

end % end of getConsensus()
%%
function fps = FPGrowth(tree, alpha)
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
%%
function fps = combinatory(items, counts, refs, n)
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
%%
function fps = crossproduct(fps_p, fps_q)
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
%%
function tree = FPTree(cpbases, counts, refs, n)
global xi; global ni;
C_1 = zeros(1, ni);
R1 = cell(1, ni);
for i=1:n
    cnt = counts(i);
    for j=1:length(cpbases{i})
        item = cpbases{i}(j);
        C_1(item) = C_1(item) + cnt;
        R1{item} = union(R1{item}, refs{i});
    end
end

F1 = find(C_1 >= xi);  % frequent size-1 itemset
C_1 = C_1(F1);
R1 = {R1{F1}};

[C1 I] = sort(C_1, 'descend');
L1 = F1(I); % sort F1 in descending order and save in L1
R1 = {R1{I}};

% construct header list
headlist = pointer(NewList(L1, C1, R1));
root = 0;
if headlist.size > 0
    % adjust conditional pattern bases to only contain frequent items
    fibases = cell(n,1);
    counts2 = zeros(n,1);
    firefs = cell(n,1);
    n2 = 0;
    for i=1:n
        [items IA] = intersect(L1, cpbases{i});
        if ~isempty(items)
            n2 = n2 + 1;
            [X IB] = sort(IA);
            fibases{n2} = items(IB);
            counts2(n2) = counts(i);
            firefs{n2} = refs{i};
        end
    end
    % construct FP-tree
    if n2 > 0
        root = pointer(NewNode(0, sum(counts2(1:n2)), []));
        for i=1:n2
            InsertTree(fibases{i}, counts2(i), firefs{i}, root, headlist);
        end
    end
end
tree.headlist = headlist;
tree.root = root;

end % end of FPTree()
%%
function InsertTree(path, count, refs, node, headlist)
m = length(path); assert(m > 0);
p = path(1);

prev = 0;
child = node.first_child;
while child ~= 0
    if child.item_name == p, break; end
    prev = child;
    child = child.next_sibling;
end

if child ~= 0 % node has a child whose name equals that of p
    child.count = child.count + count;
    child.refs = union(child.refs, refs);
    pnode = child;
else
    newnode = pointer(NewNode(p, count, refs));
    newnode.parent = node;
    if prev ~= 0
        prev.next_sibling = newnode;
    else
        node.first_child = newnode;
    end
    idx = find(headlist.items == p);
    assert(idx > 0);
    newnode.node_link = headlist.heads{idx};
    headlist.heads{idx} = newnode;
    pnode = newnode;
end

if m > 1
    InsertTree(path(2:m), count, refs, pnode, headlist);
end

end % end of InsertTree()
%%
function node = NewNode(name, count, refs)
node = struct('item_name', name, 'count', count, 'refs', refs, 'parent', 0, 'first_child', 0, 'next_sibling', 0, 'node_link', 0);
end % end of NewNode()
%%
function list = NewList(items, counts, refs)
list = struct('size', length(items), 'items', items, 'counts', counts);
list.refs = refs;
list.heads = num2cell(zeros(length(items), 1));
end % end of NewList()