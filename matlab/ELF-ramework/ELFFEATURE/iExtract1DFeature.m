function [fout] = iExtract1DFeature(featName, rawPath, mode)

%%
methodRaw = 'raw';
methodResize = 'resize';
methodCrop = 'cropcenter';
methodHog= 'hog';
methodDct = 'dct';
methodS3 = 's3';
methodHsvHist = 'hsvhist';
methodHist = 'histogram';

if nargin == 0
    fout = {methodRaw, methodResize, methodCrop, methodHog, methodDct, methodS3, methodHsvHist, methodHist};
    return;
end

%% Prepare
i = 1;
f_ = [];
SZ = 256;
block_sz = 32;
img = readDataToImg(rawPath);

while(i < length(featName))
    switch(featName{i})
        case methodRaw
            img_r = double(imresize(img, [block_sz , block_sz ]));
            img_r = img_r./255;
            f_ = reshape(img_r, [1, block_sz * block_sz * size(img_r, 3)]);

        case methodResize
            img_ = imresize(img, [block_sz block_sz]);
            f_ =  single(img_)/255;
            
        case methodCrop
            img_ = olCropCenter(img, block_sz);
            f_ = single(img_)/255;
            
        case methodHog
            imgc = olCropCenter(img, block_sz);
            cellSize = 8 ;
            t_hog = vl_hog(single(imgc), cellSize) ;
            [M, N, P] = size(t_hog);
            f_ = reshape(t_hog, [1, M * N * P]);
            
        case methodDct
            imgc = rgb2gray(img);
            imglogdct = single(log(abs(dct2(imgc))));
            [M, N, P] = size(imglogdct);
            f_= reshape(imglogdct, [1, M * N * P]);
            
        case methodS3
            maxK = 700;
            s_map = spatial_map(double(rgb2gray(img)), 8);
            B = sort(s_map(:), 'descend');
            f_ = B(1:maxK)';
            
        case methodHsvHist
            hsv = rgb2hsv(img_r);
            f_ = hsv(:)';
            
        case colorHist
            maxK = 50;
            nBins = 5;
            Nind = 1; % Normalization index
            H = iRgbHistFast(img, nBins, Nind);
            B = sort(H(:), 'descend');
            f_ = B(1:maxK)';
            
        case methodHist
            maxK = 50;
            H = hist(double(rgb2gray(img)), 64);
            B = sort(H(:), 'descend');
            % [B, mu, sigma] = iFeatureNormalize(B);
            f_ = B(1:maxK)';
            
        otherwise
    end
    
    feat = cat(3, feat, f_);
    f_ = [];
    i  = i + 1;
end

fout = feat;

end