function PrintRules(rules_left, rules_right)%��ӡ��������

fid = fopen(strcat('F:\github\DataMining\Apriori\printrules_s', '.txt'), 'wt');

fprintf(fid, '-------------------------------Rules------------------------------\n');
for i =1:size(rules_left,1)
    fprintf(fid, 'R%2d:                ',i);
    items = nonzeros(rules_left(i,:));%��ӡ������
    for j=1:size(items,1)
       fprintf(fid, '%d', rules_left(i, j));
       if(j == size(items,1))
           fprintf(fid, ' ==> ');
       else
           fprintf(fid, ', '); 
       end     
    end
    
    items = nonzeros(rules_right(i,:));%��ӡ�����Ҳ�
    for j=1:size(items,1)
       fprintf(fid, '%d', rules_right(i, j));
       if(j == size(items,1))
           fprintf(fid, '\n');
       else
           fprintf(fid, ', '); 
       end   
    end
end

fprintf(fid, '------------------------------------------------------------------\n\n\t');