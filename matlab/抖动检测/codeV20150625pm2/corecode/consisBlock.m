function [ imageInf ] = consisBlock( label,WminRow,xNum )
%% һ���߽�ͼ���ֳ������֣������־�����һ���ԣ�ͼ��ž��оֲ�һ����
% ���ض����ж�(0,1)��ͼ������ƫ����
imageInf = [0,0];
for i = 1:xNum-1   
    [ conFlag1,meanWmin1 ] = consistency( label(1:i,:), WminRow(1:i,:));
    [ conFlag2,meanWmin2 ] = consistency( label(i+1 : end,:), WminRow(i+1 : end,:)); 
    if conFlag1==1 && conFlag2==1 %�������һ����
        Wmin = [meanWmin1,meanWmin2];
        [~,idx] = max(abs(Wmin));
        imageInf = [1,Wmin(idx)]; %����ƫ����Ϊ����ֵ���һ��
        return;
    else
        continue;
    end
end
end

