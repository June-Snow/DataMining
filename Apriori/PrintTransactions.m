function PrintTransactions(dataset)%��ӡ����

fprintf('-------------------------Transaction List-------------------------\n');
for i =1:size(dataset,1)%��ȡ����ĸ������˴�Ϊ���������������i������
    fprintf('T%2d:                ',i);
    items = nonzeros(dataset(i,:));%ȡ�����е��������ÿ�еķ���Ԫ�أ�
    %��������б�
    for j=1:size(items,1)%��j��
       fprintf('%d', dataset(i, j));
       if(j == size(items,1))
           fprintf('\n');
       else
           fprintf(', '); 
       end           
    end    
end

fprintf('------------------------------------------------------------------\n\n');