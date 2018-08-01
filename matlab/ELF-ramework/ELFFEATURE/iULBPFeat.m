function [ ulbpMap, ulbpFeatVec ] = iULBPFeat( img, himgresize, wimgresize )

%% 灰度化并缩放img到指定大小
if size(img,3) == 3
    Img = rgb2gray(img);
else
    Img = img;
end

if nargin >1
    Img = imresize(Img, [himgresize wimgresize]);
end
[m n] = size(Img);


%% 计算LBP值
I = zeros(m+2, n+2);
I(2:m+1, 2:n+1) = Img;

A = zeros(m+2, n+2, 8);
B = zeros(m+2, n+2);
count = zeros(m+2, n+2);

% 按下面顺序赋值
% |1|2|3|
% |8|0|4|
% |7|6|5|
A(3:m+2, 3:n+2, 1) = Img;
A(3:m+2, 2:n+1, 2) = Img;
A(3:m+2, 1:n  , 3) = Img;
A(2:m+1, 1:n  , 4) = Img;
A(1:m  , 1:n  , 5) = Img;
A(1:m  , 2:n+1, 6) = Img;
A(1:m  , 3:n+2, 7) = Img;
A(2:m+1, 3:n+2, 8) = Img;

for i = 1:8
    A(:,:,i) = A(:,:,i)>=I;
end

% 计算按不同顺序排列时的LBP值
temp =  A(:,:,1);
for j = 0:7
    temp1 =  A(:,:,mod(j,8)+1);
    comp = temp ~= temp1;
    count= count + comp; %计算跳变次数
    B = B + A(:,:,mod(j,8)+1) * 2^j;
    temp = temp1;
end

flag = count(2:m+1, 2:n+1);
ulbpMap = B(2:m+1, 2:n+1);
ulbpMap(flag>2) = -1; %将跳变大于2的赋值为-1

if nargout == 2
    ulbpFeatVec = ULBP_HistCal(ulbpMap);
end
end

function [ulbp_hist] = ULBP_HistCal(ulbpMap)

% ulbp_hist = hist(ulbpMap,257);
% ulbp_hist = ulbp_hist(ulbp_hist~=0);
index = [ 0 1 2 3 4 6 7 8 12 14 15 16 24 28 30 31 32 48 56 60 62 63 64 96 112 ...
    120 124 126 127 128 129 131 135 143 159 191 192 193 195 199 207 223 ...
    224 225 227 231 239 240 241 243 247 248 249 251 252 253 254 255 -1];
ulbp_hist = zeros(1,59);
[m n] = size(ulbpMap);
for i = 1:m
    for j = 1:n
        pos = index==ulbpMap(i,j);
        ulbp_hist(pos) = ulbp_hist(pos) + 1;
    end
end
ulbp_hist = ulbp_hist/(m*n);
end

