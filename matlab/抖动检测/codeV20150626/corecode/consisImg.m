function [ imageInf ] = consisImg( label, WminRow,xNum,yNum )
%% �ж�ͼ��λ��һ���ԣ����ض����ж�(0,1)��ͼ������ƫ����
%% �ж�ͼ���ȫ��һ����
[ conFlag,meanWmin ] = consistency( label, WminRow); %��һ���Լ��㣬����λ�Ƽ������Ƿ�һ��
if conFlag==1 
    if meanWmin==0 %����һ���ԣ�����ƫ��
        imageInf = [ 0,0 ]; %��������ƫ����Ϊ0
    else %����һ���ԣ�ƫ����Ϊƽ����
        imageInf = [ 1,meanWmin ];
    end
    return;  %��ͼ������һ�£��򷵻أ������жϾֲ�һ����  
end
%% �ж�ͼ���ֲ�һ����
imageInf = consisBlock( label,WminRow,xNum );%�ֲ�����һ�����ж�
if sum(imageInf==[0,0])==2 %����������Ҳ���һ���ԣ�������������
    imageInf = consisBlock( label',WminRow',yNum );
else
    return;
end
end

