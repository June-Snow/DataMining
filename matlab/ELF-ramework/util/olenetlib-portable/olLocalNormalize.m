function ln = olLocalNormalize(IM, sigma1, sigma2)
%LOCALNORMALIZE A local normalization algorithm that uniformizes the local
%mean and variance of an image.
%  ln=localnormalize(IM,sigma1,sigma2) outputs local normalization effect of
%  image IM using local mean and standard deviation estimated by Gaussian
%  kernel with sigma1 and sigma2 respectively.
%
%  Contributed by Guanglei Xiong (xgl99@mails.tsinghua.edu.cn)
%  at Tsinghua University, Beijing, China.
IM = double(IM);
if (ndims(IM)==3)
    ln(:,:,1) = olLocalNormalize(IM(:,:,1), sigma1, sigma2);
    ln(:,:,2) = olLocalNormalize(IM(:,:,2), sigma1, sigma2);
    ln(:,:,3) = olLocalNormalize(IM(:,:,3), sigma1, sigma2);
    
else
    epsilon=1e-1;
    halfsize1=ceil(-norminv(epsilon/2,0,sigma1));
    size1=2*halfsize1+1;
    halfsize2=ceil(-norminv(epsilon/2,0,sigma2));
    size2=2*halfsize2+1;
    gaussian1=fspecial('gaussian',size1,sigma1);
    gaussian2=fspecial('gaussian',size2,sigma2);
    num=IM-imfilter(IM,gaussian1);
    den=sqrt(imfilter(num.^2,gaussian2));
    ln=num./den;
end

% NORMINV�Ƿ���ָ��ƽ��ֵ�ͱ�׼ƫ�����̬�ۻ��ֲ������ķ�����
% ���㹫ʽΪNORMINV(probability,mean,standard_dev)������
% Probability����̬�ֲ��ĸ���ֵ��0<probability<1��
% Mean�� �ֲ�������ƽ��ֵ
% Standard_dev ���ֲ��ı�׼ƫ�Standard_dev> 0��
% ��� mean = 0 �� standard_dev = 1������ NORMINV ʹ�ñ�׼��̬�ֲ���
% ����Ѹ�������ֵ���� NORMINV ʹ�� NORMDIST(x, mean, standard_dev, TRUE) = probability �����ֵ x����ˣ�NORMINV �ľ���ȡ���� NORMDIST �ľ��ȡ�