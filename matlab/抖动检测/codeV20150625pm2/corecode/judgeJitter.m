function [ VideoInf ] = judgeJitter( ImgInf,Thr )
%% ����λ���ж϶���
ImgFlag = ImgInf(:,1);
proFlag = mean(ImgFlag);  % ��ȡ��֡�б��ж�Ϊ�����ĸ���
if proFlag > Thr
    VideoInf = 1;
else
    VideoInf = 0;
end

end

