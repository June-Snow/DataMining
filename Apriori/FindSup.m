function sup = FindSup(item, L, supports)%�Ҷ�ӦƵ���item��֧�ֶ�

for i=1:size(L,1)
    l = nonzeros(L(i,:));
    if(isequal(l', item))
        sup = supports(i);
    end
end

