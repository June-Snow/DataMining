function ChangePictureSize(image, path, width, height, name)
%���������ϢͼƬ�ߴ��С��ʹ���ʺ����в�ͬѵ��ͼƬ�ߴ�Ҫ��
SZ = [height, width];
[M, N, ~] = size(image);

if(M > 2*height)
    image1 = image(1:floor(M/2), :, :);
    ChangePictureSize(image1, path, width, height, name);
    image2 = image(floor(M/2):M, :, :);
    ChangePictureSize(image2, path, width, height, name);
elseif(N > 2*width)
    image1 = image(:, 1:floor(N/2), :);
    ChangePictureSize(image1, path, width, height, name);
    image2 = image(:, floor(N/2):N, :);
    ChangePictureSize(image2, path, width, height, name);
else
    if(M < height && N < width)
        d = min(M, N);
        newI = ReflectEdgeColor(image, d-1, 0);%����ͼƬ�ߴ�
        [M, N, ~] = size(newI);
        if(M >= height && N >= width)
            CropCenter(newI, SZ, path, name);%ȡͼƬ��������
        else
            d = min(M, N);
            newI = ReflectEdgeColor(newI, d-1, 0);%����ͼƬ�ߴ�
            [M, N, ~] = size(newI);
            if(M >= height && N >= width)
                CropCenter(newI, SZ, path, name);%ȡͼƬ��������
            end
        end
        
    elseif(M < height)
        newI = ReflectEdgeColor(image, M-1, 1);%����ͼƬ�ߴ�
        [M, N, ~] = size(newI);
        if(M >= height && N >= width)
            CropCenter(newI, SZ, path, name);%ȡͼƬ��������
        else
            newI = ReflectEdgeColor(newI, M-1, 1);%����ͼƬ�ߴ�
            [M, N, ~] = size(newI);
            if(M >= height && N >= width)
                CropCenter(newI, SZ, path, name);%ȡͼƬ��������
            end
        end
        
    elseif(N < width)
        newI = ReflectEdgeColor(image, N-1, 2);%����ͼƬ�ߴ�
        [M, N, ~] = size(newI);
        if(M >= height && N >= width)
            CropCenter(newI, SZ, path, name);%ȡͼƬ��������
        else
            newI = ReflectEdgeColor(newI, N-1, 2);%����ͼƬ�ߴ�
            [M, N, ~] = size(newI);
            if(M >= height && N >= width)
                CropCenter(newI, SZ, path, name);%ȡͼƬ��������
            end
        end
        
    elseif((M < 1.5*height) && (N < 1.5*width))
        CropCenter(image, SZ, path, name);%ȡͼƬ��������
        
    elseif((M < 1.5*height) && (N > 1.5*width))
        image1 = image(:, 1:width, :);
        CropCenter(image1, SZ, path, name);%ȡͼƬ��������
        image1 = image(:, N-width+1:N, :);
        CropCenter(image1, SZ, path, name);%ȡͼƬ��������

    elseif((M > 1.5*height) && (N < 1.5*width))
        image1 = image(1:height, :, :);
        CropCenter(image1, SZ, path, name);%ȡͼƬ��������
        image1 = image(M-height+1:M, :, :);
        CropCenter(image1, SZ, path, name);%ȡͼƬ��������

    elseif((M <= 2*height) && (N <= 2*width))
        Crop5Part(image, SZ, path, name);%ȡ5��
        
    end
    
end

end

function newI = ReflectEdgeColor(I, d, type)
%% ��չͼ��߽�
[M, N, ~] = size(I);
if type == 0 %��������
    newI = zeros(M + 2 * d, N + 2 * d, 3, 'uint8');
    newI(d+1 : d+M, d+1 : d+N, :) = I;%�м䲿��
    newI(1 : d, d+1 : d+N, :) = I(d : -1 : 1, : , :);%��
    newI(end-d : end, d+1 : d+N, :) = I(end : -1 : end-d, : , :);%��
    newI( : , 1 : d, :) = newI( : , 2*d : -1 : d+1, :);%��
    newI( : , N+d+1 : N+2*d, :) = newI( : , N+d : -1 : N+1, :);%��
    
elseif type == 1 %����
    newI = zeros(M + 2 * d, N, 3, 'uint8');
    newI(d+1 : d+M, 1 : N, :) = I;%�м䲿��
    newI(1 : d,  : , :) = I(d : -1 : 1, : , :);%��
    newI(end-d : end,  : , :) = I(end : -1 : end-d, : , :);%��

elseif type == 2 %����
    newI = zeros(M, N + 2 * d, 3, 'uint8');
    newI(1 : M, d+1 : d+N, :) = I;%�м䲿��
    newI( : , 1 : d, :) = I( : , d : -1 : 1, :);%��
    newI( : , end-d : end, :) = I( : , end: -1 : end-d, :);%��
    
end

end

function [] = CropCenter(I, SZ, path, name)
%%
[M, N, ~] = size(I);
center_m = ceil(M/2);
center_n = ceil(N/2);
output = I( max(center_m - floor(SZ(1)/2), 1) : min(center_m+floor(SZ(1)/2), M), ...
    max(center_n-SZ(2)/2,1) : min(center_n+floor(SZ(2)/2), N), :);
output = imresize(output, SZ);
SaveImg(output, path, name);
% savePath = strcat(path, name);
% imwrite(output, savePath);

end

function [] = Crop5Part(I, SZ, path, name)
%% 
[M, N, ~] = size(I);
output = I(1:SZ(1), 1:SZ(2), :);
SaveImg(output, path, name);


output = I(1:SZ(1), N-SZ(2)+1:N, :);
SaveImg(output, path, name);

output = I(M-SZ(1)+1:M, 1:SZ(2), :);
SaveImg(output, path, name);

output = I(M-SZ(1)+1:M, N-SZ(2)+1:N, :);
SaveImg(output, path, name);

CropCenter(I, SZ, path, name);


end

function SaveImg(image, path, name)
%�ж�ͼƬ�Ƿ���ڣ����������������
for i = 0 : 100
    imgName = strcat(name, num2str(i), '.jpg');
    if ~exist(strcat(path, imgName), 'file')
        imwrite(image, strcat(path, imgName));
        break;
    end
end
end


