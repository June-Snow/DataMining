function c = CheckSup(dataset, item)%�������֧�ֶȣ��������г��ֵĴ�����

n = size(dataset,1);%����ĸ���
c = 0;%֧�ֶȣ���ʼΪ0
for i=1:n
    if(all(ismember(item,dataset(i,:))) == 1)%�������������i��
        c = c+1;
    end
end

