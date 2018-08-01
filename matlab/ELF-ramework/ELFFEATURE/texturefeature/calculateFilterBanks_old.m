function [feat] = calculateFilterBanks_old(img) %, type, numberOfStatistics)
%%17个模板与图片进行卷积操作，H是一个[:, :, 17]的数组。
%img = imread('F:\图片库\树叶\树叶样本\18_00030.bmp');
%if nargin < 3
%    numberOfStatistics = 1;
%end

persistent L3 E3 S3 gMask		% the Laws' masks
persistent NB1 NB2 NB3 NB4 NB5 NB6

nLaw = 17;

%nLaw                 = 0;
%nRadon               = 0;
%nHarris              = 0;
%harrisSmoothingWidth = 9;

%switch lower(type)
%    case 'purelaws'
%        nLaw = 9;
%    case {'laws', 'texture'}
%        nLaw = 17;
%    case {'harris', 'texture'}
%        nHarris = 10;
%    case {'radon'}
%        nRadon = nTopRadon*180/thetaStep;
%    case {'lawsradon'}
%        nLaw = 17;
%        nRadon = nTopRadon*180/thetaStep;
%    case {'lawsharris'}
%        nLaw = 17;
%        nHarris = 10;
%end
%nDim = nLaw + nHarris;
 
%convultional filters
if length(L3) <= 0
    MatrixConditioner = .2;
    L3 = [1 2 1]/128/MatrixConditioner;      %不懂
    E3 = [-1 0 1];
    S3 = [-1 2 -1];
    %L5 = [1 2 3 2 1];       %can be improved
    %L7 = [1 2 3 4 3 2 1];   % can be improved
    gMask = gaussMask(4,1.4);
    
    %Navatia Babu filters oriented at six angles (0,30,60,90,120,150)
    NB1 = [ -100, -100, 0, 100, 100; ...
            -100, -100, 0, 100, 100; ...
            -100, -100, 0, 100, 100; ...
            -100, -100, 0, 100, 100; ...
            -100, -100, 0, 100, 100];
    NB2 = [ -100, 32, 100, 100, 100; ...
            -100,-78, 92,  100, 100; ...
            -100,-100, 0,  100, 100; ...
            -100,-100,-92, 78,  100; ...
            -100,-100,-100,-32, 100];
    
    NB1 = NB1/2000;
    NB2 = NB2/2000;
        
    NB3 = -NB2';
    NB4 = -NB1';
    NB5 = -NB3(end:-1:1,:);
    NB6 = NB5'; 
end

ycbcr_img = double(rgb2ycbcr(img)); %This computer has no image processing functions!!%y表示亮度分量，cbcr色度分量。

%ycbcr_img(:,:,1) = ycbcr_img(:,:,1) - mean( mean( ycbcr_img(:,:,1) ));
%ycbcr_img(:,:,2) = ycbcr_img(:,:,2) - mean( mean( ycbcr_img(:,:,2) ));
%ycbcr_img(:,:,3) = ycbcr_img(:,:,3) - mean( mean( ycbcr_img(:,:,3) ));

imgY = ycbcr_img(:,:,1);% - mean( mean( ycbcr_img(:,:,1) ));
%imgEdge = edge(imgY, 'sobel');

clear img;
H = zeros( size(imgY,1), size(imgY,2), nLaw);
%L3img = conv2(imgY, L3, 'valid');
%E3img = conv2(imgY, E3, 'valid');
%S3img = conv2(imgY, S3, 'valid');
%E3imgT = conv2(imgY, E3', 'valid');

temp = conv2(imgY, L3'*L3, 'valid');
temp = [ temp(1*ones(1,round((size(L3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(L3,2)-1-round((size(L3,2)-1)/2))),:)];
H(:,:,1) = [temp(:,1*ones(1,round((size(L3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(E3,2)-1-round((size(E3,2)-1)/2))))];

temp = conv2(imgY, L3'*E3, 'valid');
temp = [ temp(1*ones(1,round((size(L3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(L3,2)-1-round((size(L3,2)-1)/2))),:)];
H(:,:,2) = [temp(:,1*ones(1,round((size(E3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(E3,2)-1-round((size(E3,2)-1)/2))))];

temp = conv2(imgY, L3'*S3, 'valid');
temp = [ temp(1*ones(1,round((size(L3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(L3,2)-1-round((size(L3,2)-1)/2))),:)];
H(:,:,3) = [temp(:,1*ones(1,round((size(S3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(S3,2)-1-round((size(S3,2)-1)/2))))];

temp = conv2(imgY, E3'*L3, 'valid');
temp = [ temp(1*ones(1,round((size(E3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(E3,2)-1-round((size(E3,2)-1)/2))),:)];
H(:,:,4) = [temp(:,1*ones(1,round((size(L3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(L3,2)-1-round((size(L3,2)-1)/2))))];

temp = conv2(imgY, E3'*E3, 'valid');
temp = [ temp(1*ones(1,round((size(E3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(E3,2)-1-round((size(E3,2)-1)/2))),:)];
H(:,:,5) = [temp(:,1*ones(1,round((size(E3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(E3,2)-1-round((size(E3,2)-1)/2))))];

temp = conv2(imgY, E3'*S3, 'valid');
temp = [ temp(1*ones(1,round((size(E3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(E3,2)-1-round((size(E3,2)-1)/2))),:)];
H(:,:,6) = [temp(:,1*ones(1,round((size(S3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(S3,2)-1-round((size(S3,2)-1)/2))))];

temp = conv2(imgY, S3'*L3, 'valid');
temp = [ temp(1*ones(1,round((size(S3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(S3,2)-1-round((size(S3,2)-1)/2))),:)];
H(:,:,7) = [temp(:,1*ones(1,round((size(L3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(L3,2)-1-round((size(L3,2)-1)/2))))];

temp = conv2(imgY, S3'*E3, 'valid');
temp = [ temp(1*ones(1,round((size(S3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(S3,2)-1-round((size(S3,2)-1)/2))),:)];
H(:,:,8) = [temp(:,1*ones(1,round((size(E3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(E3,2)-1-round((size(E3,2)-1)/2))))];

temp = conv2(imgY, S3'*S3, 'valid');
temp = [ temp(1*ones(1,round((size(S3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(S3,2)-1-round((size(S3,2)-1)/2))),:)];
H(:,:,9) = [temp(:,1*ones(1,round((size(S3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(S3,2)-1-round((size(S3,2)-1)/2))))];

temp = conv2( (ycbcr_img(:,:,2)), L3'*L3, 'valid');%颜色通道
temp = [ temp(1*ones(1,round((size(L3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(L3,2)-1-round((size(L3,2)-1)/2))),:)];
H(:,:,10) = [temp(:,1*ones(1,round((size(L3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(L3,2)-1-round((size(L3,2)-1)/2))))];

temp = conv2( (ycbcr_img(:,:,3)), L3'*L3, 'valid');%颜色通道
temp = [ temp(1*ones(1,round((size(L3,2)-1)/2)),:); temp;...
             temp(end*ones(1,(size(L3,2)-1-round((size(L3,2)-1)/2))),:)];
H(:,:,11) = [temp(:,1*ones(1,round((size(L3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(L3,2)-1-round((size(L3,2)-1)/2))))];

%H(:,:,12) = conv2(E3img, L5', 'valid');
%H(:,:,13) = conv2(E3img, L7', 'valid');
%H(:,:,13) = conv2(E3imgT, L5, 'valid');
%H(:,:,15) = conv2(E3imgT, L7, 'valid');

temp = conv2(imgY, NB1, 'valid');
temp = [ temp(1*ones(1,round((size(NB1,1)-1)/2)),:); temp;...
             temp(end*ones(1,(size(NB1,1)-1-round((size(NB1,1)-1)/2))),:)];
H(:,:,12) = [temp(:,1*ones(1,round((size(NB1,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(NB1,2)-1-round((size(NB1,2)-1)/2))))];

temp = conv2(imgY, NB2, 'valid');
temp = [ temp(1*ones(1,round((size(NB2,1)-1)/2)),:); temp;...
             temp(end*ones(1,(size(NB2,1)-1-round((size(NB2,1)-1)/2))),:)];
H(:,:,13) = [temp(:,1*ones(1,round((size(NB2,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(NB2,2)-1-round((size(NB2,2)-1)/2))))];

temp = conv2(imgY, NB3, 'valid');
temp = [ temp(1*ones(1,round((size(NB3,1)-1)/2)),:); temp;...
             temp(end*ones(1,(size(NB3,1)-1-round((size(NB3,1)-1)/2))),:)];
H(:,:,14) = [temp(:,1*ones(1,round((size(NB3,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(NB3,2)-1-round((size(NB3,2)-1)/2))))];

temp = conv2(imgY, NB4, 'valid');
temp = [ temp(1*ones(1,round((size(NB4,1)-1)/2)),:); temp;...
             temp(end*ones(1,(size(NB4,1)-1-round((size(NB4,1)-1)/2))),:)];
H(:,:,15) = [temp(:,1*ones(1,round((size(NB4,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(NB4,2)-1-round((size(NB4,2)-1)/2))))];

temp = conv2(imgY, NB5, 'valid');
temp = [ temp(1*ones(1,round((size(NB5,1)-1)/2)),:); temp;...
             temp(end*ones(1,(size(NB5,1)-1-round((size(NB5,1)-1)/2))),:)];
H(:,:,16) = [temp(:,1*ones(1,round((size(NB5,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(NB5,2)-1-round((size(NB5,2)-1)/2))))];

temp = conv2(imgY, NB6, 'valid');
temp = [ temp(1*ones(1,round((size(NB6,1)-1)/2)),:); temp;...
             temp(end*ones(1,(size(NB6,1)-1-round((size(NB6,1)-1)/2))),:)];
H(:,:,17) = [temp(:,1*ones(1,round((size(NB6,2)-1)/2))) temp...
            temp(:,end*ones(1,(size(NB6,2)-1-round((size(NB6,2)-1)/2))))];

%H = abs(H);

% cc = H(:,:,1);
% minVal = min(cc(:));
% diffVal = max(cc(:))-min(cc(:));
% H(:,:,1) =  (cc-minVal) / diffVal;      

feat = [];
for i = 1 : 17
    cc = H(:,:,i);
    f_ = MinMaxNormalization(cc);
    feat = cat(3, feat, f_);
end

%H = H.^2;      %Energy 
return;
end


function cc = MinMaxNormalization(dim)
%% 对原始数据的线性变换，使结果值映射到[0 - 1]之间
minVal = min(dim(:));
diffVal = max(dim(:))-min(dim(:));
cc = (dim-minVal) / diffVal; 

end


%=======for Harris texture gradient ===========
%Ix2 = conv2(H2(:,:,12), gMask, 'valid');
%Iy2 = conv2(H2(:,:,14), gMask, 'valid');
%Ixy = conv2(H(:,:,12) .* H(:,:,14), gMask, 'valid');

%anglesHarris = zeros( size(Ix2,1), size(Ix2,2), 2);
%eigValue = zeros( size(Ix2,1), size(Ix2,2), 2);
%upsilon = 1e-23;

%gradientMagImage = sqrt(H2(:,:,12) + H2(:,:,14) );
%angleImage = round( (nHarris-1) * (pi/2+atan( H(:,:,12) ./ (H(:,:,14)+upsilon))) /pi) + 1;

