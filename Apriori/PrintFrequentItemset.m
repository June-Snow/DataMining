function PrintFrequentItemset(L, supports)%��ӡƵ���������Ӧ֧�ֶ�

fprintf('---------------------Frequent Itemset|Suppoort--------------------\n');
for i =1:size(L,1)
    fprintf('FI%2d:               ',i);
    items = nonzeros(L(i,:));
    for j=1:size(items,1)
       fprintf('%d', L(i, j));
       if(j == size(items,1))
           fprintf('|support:');
       else
           fprintf(', '); 
       end           
    end
    fprintf('%d\n', supports(i)); 
end

fprintf('------------------------------------------------------------------\n\n');