function [ VideoInf ] = judgeJitter( ImgInf,Thr )
%% ����ͼ�����Ϣ�������жϡ�����ƫ��������ǰ֡���ο�֡���ж���Ƶ��������(�����жϡ�����Ƶ�ʡ����)
%% �������Ա���㶶������
ImgInf(:,2) = dirFilter(ImgInf(:,2));%�Ե�ǰ�����˲�
basicDir = direGroup(ImgInf); %�����׼����
ImgInf = direLable( basicDir,ImgInf ); %���ջ�׼���򣬽���ǰ�����Ϊ������
%%


end

