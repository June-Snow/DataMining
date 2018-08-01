function InsertTree(path, count, refs, node, headlist)
%% 
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