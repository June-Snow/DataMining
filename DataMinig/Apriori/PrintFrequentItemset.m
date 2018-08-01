function PrintFrequentItemset(L, supports)%打印频繁项集及其相应支持度
%fid = fopen(strcat('F:\github\DataMining\Apriori\printFrequentItenset_n', '.txt'), 'wt');
%fprintf(fid, '---------------------Frequent Itemset|Suppoort--------------------\n');
num = zeros(1*9);
count = 1;
numcount = 0;
for i =1:size(L,1)
    %fprintf(fid, 'FI%2d:               ',i);
    items = nonzeros(L(i,:));

    for j=1:size(items,1)
     %  fprintf(fid, '%d', L(i, j));
       if(j == size(items,1))
         %  fprintf(fid, '|support:');
       else
         %  fprintf(fid, ', '); 
       end           
    end
    if(i == 1)
        num(1) =  supports(i);
    end
    if(i>1)
    if(size(nonzeros(L(i-1,:)), 1) == size(nonzeros(L(i,:)), 1))
        num(count) = num(count) + supports(i);
    else
        count = count + 1;
        num(count) =supports(i);
        
    end
    end
    numcount = numcount + supports(i);
   % fprintf(fid, '%d\n', supports(i)); 
end

numcount = numcount + 1;
%fprintf(fid, '------------------------------------------------------------------\n\n');