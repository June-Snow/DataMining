function PrintRules(rules_left, rules_right)%��ӡ��������


fprintf('-------------------------------Rules------------------------------\n');
for i =1:size(rules_left,1)
    fprintf('R%2d:                ',i);
    items = nonzeros(rules_left(i,:));%��ӡ������
    for j=1:size(items,1)
       fprintf('%d', rules_left(i, j));
       if(j == size(items,1))
           fprintf(' ==> ');
       else
           fprintf(', '); 
       end           
    end
    
    items = nonzeros(rules_right(i,:));%��ӡ�����Ҳ�
    for j=1:size(items,1)
       fprintf('%d', rules_right(i, j));
       if(j == size(items,1))
           fprintf('\n');
       else
           fprintf(', '); 
       end           
    end
end

fprintf('------------------------------------------------------------------\n\n');