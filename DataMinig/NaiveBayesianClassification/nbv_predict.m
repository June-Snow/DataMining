function [test_label,predict_prob]=nbv_predict(data,pxj,pj)

N=size(data,1);
wn=length(pj);
predict_prob(1:N,1:wn)=0;

for k=1:N
    for j=1:wn
        idx=(data(k,:)>0);
        predict_prob(k,j)=mul(pxj(j,idx))*pj(j);
    end
end
[~,test_label]=max(predict_prob');
end


function value=mul(vector)

    m=length(vector);
    value=1;
    
    for i=1:m
       value=value*vector(i); 
    end

end