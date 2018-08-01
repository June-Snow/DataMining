%һ
%�Ը�˹ƽ���ֳ�����:   һ�õ���˹ƽ�������ľ���
%                      ����ͼ����ƽ������,��ͼ��ı߽�Ĵ������ǶԳ�

%Ȩֵ֮��Ϊ��
function r=GuassionMatrix(delta,radius)
    radius=ceil(radius);
    n=2*radius+1;
    r=zeros(n,n);
    %tempMatrix=zeros(radius,radius);
    for i=-radius:radius
        for j=-radius:radius
            r(i+radius+1,j+radius+1)=exp(-(i^2+j^2)/2*delta^2);
        end
    end
    r=round(100*r);   
    r=r/sum(sum(r));
end

