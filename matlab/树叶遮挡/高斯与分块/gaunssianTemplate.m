function h=gaunssianTemplate(size,sigma)  
%size为模板大小  
%sigma为标准差  
  
%下面的代码其实是从fspecial中摘录出来的，我做了一些更改放到自己写的函数里面便于解释  
%计算高斯模板的中心位置  
siz    = ([size size]-1)/2;  
sig    = sigma;  
 
%用meshgrid是为了加速，不用for循环  
[x y]  = meshgrid(-siz(2):siz(2),-siz(1):siz(1));  
   
%计算exp(-(x^2+y^2)/(2*sig^2))  
%我想你肯定有一个疑问，那就是为什么不除以2*pi*sig^2  
%因为不除也没有关系，因为最后归一化之后会约掉  
arg    = -(x.*x+y.*y)./(2*sig*sig);  
h      = exp(arg);  
  
%不知道它为什么要这样，忘懂得人解释一下  
h(h<eps*max(h(:))) = 0;  
  
%求和，用来归一化  
sumh   = sum(h(:));  
 
%防止求和之后出现为0的情况，然后再归一化一下使高斯，模板为小数  
if sumh ~=0  
    h=h/sumh;  
end  
  
end  