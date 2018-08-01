    
%----------------------------------------------
%向下采样
function r=DownSample(im)
    [m,n,z]=size(im);
    r=zeros(m/2,n/2,z);
    for i=1:m/2
        for j=1:n/2
            r(i,j,:)=im(2*i,2*j,:);
        end
    end
end