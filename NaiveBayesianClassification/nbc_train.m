function [ pxj,pj ] = nbc_train( data,label )

[N,l]=size(data);
wn=length(unique(label));
wm(1:wn)=0;
pxj=zeros(wn,l);

for j=1:wn
   idx=(label==(j-1));
   wm(j)=sum(idx); 
   pxj(j,:)=(sum(data(idx,:)>0)+1)/(wm(j)+wn);
end

pj=wm/N;

end








