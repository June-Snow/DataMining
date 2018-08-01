function tree = FPTree(cpbases, counts, refs, n)
%%
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
