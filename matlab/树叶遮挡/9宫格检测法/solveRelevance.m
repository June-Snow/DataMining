function nuncell1 = solveRelevance(nuncell1, nuncell2)
%% ���Qnuncell�е��ַ���������������չ��nuncell2������nuncell1 ��nuncell2�����ӹ�ϵ
%nuncell1 ��nuncell2 ��һ��Ǵ洢��01�ַ�������nuncell1�е�һ��0�ַ��ĳ�1��nuncell2�н��бȶԣ�������ϵ
for i = 1 : length(nuncell1)
    max_count = 0;
    index = 0;
    origin = strfind(nuncell1{i, 1},'1');
    origin_len = length(origin);
    len = length(nuncell2);
    if(len == 2)
        len = len - 1;
    end
    for j = 1 : len %length(nuncell2)
        target = strfind(nuncell2{j, 1},'1');
        target_len = length(target);
        l = 1;
        m = 1;
        count_equ = 0;
        for k = 1 : 9
            if((l <= target_len)&&m <= origin_len)
                if(origin(m) == target(l))
                    l = l + 1;
                    m = m + 1;
                    count_equ = count_equ + 1;
                elseif(origin(m) < target(l))
                    m = m + 1;
                else
                    l = l + 1;
                end
            end
        end
        if(count_equ == origin_len)
            if(max_count < nuncell2{j, 2})
                max_count = nuncell2{j, 2};
                max_nuncell{1} = nuncell2{j, 1};
                index = 1;
            end
        end
    end
    if(index ~= 0)
        nuncell1(i,3) = max_nuncell;
    else
        max_nuncell{1} = '000000000';
        nuncell1(i,3) = max_nuncell;
    end

end

end