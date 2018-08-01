function h=gaunssianTemplate(size,sigma)  
%sizeΪģ���С  
%sigmaΪ��׼��  
  
%����Ĵ�����ʵ�Ǵ�fspecial��ժ¼�����ģ�������һЩ���ķŵ��Լ�д�ĺ���������ڽ���  
%�����˹ģ�������λ��  
siz    = ([size size]-1)/2;  
sig    = sigma;  
 
%��meshgrid��Ϊ�˼��٣�����forѭ��  
[x y]  = meshgrid(-siz(2):siz(2),-siz(1):siz(1));  
   
%����exp(-(x^2+y^2)/(2*sig^2))  
%������϶���һ�����ʣ��Ǿ���Ϊʲô������2*pi*sig^2  
%��Ϊ����Ҳû�й�ϵ����Ϊ����һ��֮���Լ��  
arg    = -(x.*x+y.*y)./(2*sig*sig);  
h      = exp(arg);  
  
%��֪����ΪʲôҪ�������������˽���һ��  
h(h<eps*max(h(:))) = 0;  
  
%��ͣ�������һ��  
sumh   = sum(h(:));  
 
%��ֹ���֮�����Ϊ0�������Ȼ���ٹ�һ��һ��ʹ��˹��ģ��ΪС��  
if sumh ~=0  
    h=h/sumh;  
end  
  
end  