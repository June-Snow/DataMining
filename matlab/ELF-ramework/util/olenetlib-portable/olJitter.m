function [J, dm, dn]= olJitter(img, degree, dm, dn)

%%
[M, N, C] = size(img);

if nargin == 1
    degree = 0.01;
end

if nargin < 4
    sim = (-1)^randi(100);
    sin = (-1)^randi(100);
    dm = sim * randi(floor(M*degree));
    dn = sin * randi(floor(N*degree));
end


%%
Mdx = (1:M)+dm>0 & (1:M)+dm<=M;
Ndx = (1:N)+dn>0 & (1:N)+dn<=N;
J = img(Mdx, Ndx, :);


end
