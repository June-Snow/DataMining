function [ conFlag,meanWmin ] = consistency( label,Wmin )
%% ��λ����λ�Ʒ���һ�»���λ�ƣ��������һ����
% ����һ�����жϼ�����λ��
%% ��ʼ��
conFlag = 0;
meanWmin = 0;
%%
[r c] = size(label);
sumLab = sum(label(:));
if sumLab==0 || sumLab==r*c 
    if sumLab==0;%��λ��
        conFlag = 1;
        return;
    else% ��λ�ƣ��ټ��λ�Ʒ���
        Wlab = Wmin<0;
        sumWLab = sum(Wlab(:));
        WminFlag = sumWLab==0 | sumWLab==r*c ;
        if WminFlag~=1 %λ�Ʒ���һ��
            return;
        else %λ�Ʒ���һ��
            conFlag = 1;
            meanWmin = mean(Wmin(:));
        end
    end
else
    return;
end