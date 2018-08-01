function [rules_left, rules_right] = Apriori(dataset, min_sup, min_conf)%Apriori�㷨����Ƶ����Լ���������

%----------����----------%
literals = unique(dataset);%�ҳ����е������0
L1 = zeros(0,1);%1-Ƶ���
supports = zeros(0,1);%Ƶ�����Ӧ��֧�ֶ�
L = zeros(0,size(literals,1));%Ƶ���
kborder = zeros(0,2);%��¼k-Ƶ�����L�еı߽�
bordercount = 0;%������¼kborder

%----------����L1----------%
for i = 1 : size(literals,1)
    if(literals(i) == 0)%��0�������
        continue;
    end
    index = find(dataset == literals(i));%�ҳ�������litertals(i)������±�
    if(size(index,1) >= min_sup)%���������С֧�ֶ�
        itemtemp = [literals(i),zeros(1, size(literals,1)-1)];
        L = [L; itemtemp];%�����
        bordercount = bordercount + 1;
        L1 = [L1; literals(i)];%1-�
        supports = [supports; size(index,1)];%1-���Ӧ֧�ֶ�
    end
end  
kborder(1,:) = [1,bordercount];

%----------��������k-Ƶ���----------%
k = 2;%��������L1����L2
while(1)
    KL = L(kborder(k-1,1):kborder(k-1,2),:);%ȡ��Lk-1
    kborder(k,1) = bordercount + 1; %��¼��Lk��L�е���ʼ�±�
    for i = 1 : size(KL,1) - 1%Lk-1��������
        for j = i + 1: size(KL,1)
            if(isequal(KL(i,1:k-2),KL(j,1:k-2)) == 1)%������������
                itemtemp = sort([KL(i,1:k-2),KL(i,k-1),KL(j,k-1)]);
                if(all(ismember(combnk(itemtemp,k-1),KL(:,1:k-1),'rows')) == 1)%ʹ��apriori���ʼ�֦--k-Ƶ���������k-1-���Ӽ�����Ƶ���
                    suptemp = CheckSup(dataset,itemtemp);%��������֧�ֶ�
                    if(suptemp >= min_sup)%����Ƶ������
                        itemtemp = [itemtemp,zeros(1,size(literals,1)-size(itemtemp,2))];%ĩβ��0
                        L = [L;itemtemp];%����Ƶ���
                        bordercount = bordercount + 1;%Lk�������+1
                        supports = [supports;suptemp];
                    end
                end
            end
        end
    end
    kborder(k,2) = bordercount;
    if(kborder(k,1) > kborder(k,2)) %��LkΪ������ֹ����
        break;
    end
    k = k + 1;
end

PrintFrequentItemset(L,supports);%��ӡƵ��������Ӧ֧�ֶ�

%----------������������----------%
rules_left = zeros(0,size(literals,1) - 1);%����ʽ��
rules_right = zeros(0,size(literals,1) - 1);%����ʽ�Ҳ�

for i = kborder(2,1) : size(L,1)%��k>=2-Ƶ�����ÿ���������������
    l = nonzeros(L(i,:))';
    sup_l = supports(i);
    for j = 1 : size(l,2) - 1%����ʽ����ĸ�����1���������-1��
        l_subset = combnk(l,j);%�l��j���Ӽ�����
        for k = 1 : size(l_subset,1)
            s = l_subset(k,:);%����
            sup_s = FindSup(s, L, supports);%�Ҷ�ӦƵ�����֧�ֶ�
            if(sup_l / sup_s >= min_conf)%����ǿ��������
                ltemp = [s,zeros(1, size(literals,1)-1-size(s,2))];
                rules_left = [rules_left; ltemp];
                l_s = setdiff(l,s);%�Ҳ�����-����ʣ�����
                rtemp = [l_s,zeros(1, size(literals,1)-1-size(l_s,2))];
                rules_right = [rules_right; rtemp];
            end
        end
    end
end
    

