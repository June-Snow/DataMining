function PrintRules(rules_left, rules_right)%打印关联规则

fid = fopen(strcat('F:\github\DataMining\Apriori\printrules_s', '.txt'), 'wt');

fprintf(fid, '-------------------------------Rules------------------------------\n');
for i =1:size(rules_left,1)
    fprintf(fid, 'R%2d:                ',i);
    items = nonzeros(rules_left(i,:));%打印规则左部
    for j=1:size(items,1)
       fprintf(fid, '%d', rules_left(i, j));
       if(j == size(items,1))
           fprintf(fid, ' ==> ');
       else
           fprintf(fid, ', '); 
       end     
    end
    
    items = nonzeros(rules_right(i,:));%打印规则右部
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