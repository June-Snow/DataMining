%一
%对高斯平滑分成两步:   一得到高斯平滑函数的矩阵
%                      二对图像做平滑操作,对图像的边界的处理方法是对称

%权值之和为零
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

