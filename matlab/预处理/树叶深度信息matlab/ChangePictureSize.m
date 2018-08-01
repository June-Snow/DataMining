function ChangePictureSize(image, path, width, height, name, num)
%���������ϢͼƬ�ߴ��С��ʹ���ʺ����в�ͬѵ��ͼƬ�ߴ�Ҫ��
SZ = [height, width];
[M, N, ~] = size(image);

if(M > 2*height)
    image1 = image(1:floor(M/2), :, :);
    num = num + 1;
    name = strcat(name, num2str(num));
    ChangePictureSize(image1, path, width, height, name, num);
    image2 = image(floor(M/2):M, :, :);
    num = num + 1;
    name = strcat(name, num2str(num));
    ChangePictureSize(image2, path, width, height, name, num);
elseif(N > 2*width)
    image1 = image(:, 1:floor(N/2), :);
    num = num + 1;
    name = strcat(name, num2str(num));
    ChangePictureSize(image1, path, width, height, name, num);
    image2 = image(:, floor(N/2):N, :);
    num = num + 1;
    name = strcat(name, num2str(num));
    ChangePictureSize(image2, path, width, height, name, num);
else
    if(M < height && N < width)
        d = min(M, N);
        newI = ReflectEdgeColor(image, d-1, 0);%����ͼƬ�ߴ�
        [M, N, ~] = size(newI);
        name1 = strcat(name, '0.jpg');
        if(M >= height && N >= width)
            CropCenter(newI, SZ, path, name1);%ȡͼƬ��������
        else
            d = min(M, N);
            newI = ReflectEdgeColor(newI, d-1, 0);%����ͼƬ�ߴ�
            [M, N, ~] = size(newI);
            if(M >= height && N >= width)
                CropCenter(newI, SZ, path, name1);%ȡͼƬ��������
            end
        end
        
    elseif(M < height)
        newI = ReflectEdgeColor(image, M-1, 1);%����ͼƬ�ߴ�
        [M, N, ~] = size(newI);
        name1 = strcat(name, '0.jpg');
        if(M >= height && N >= width)
            CropCenter(newI, SZ, path, name1);%ȡͼƬ��������
        else
            newI = ReflectEdgeColor(newI, M-1, 1);%����ͼƬ�ߴ�
            [M, N, ~] = size(newI);
            if(M >= height && N >= width)
                CropCenter(newI, SZ, path, name1);%ȡͼƬ��������
            end
        end
        
    elseif(N < width)
        newI = ReflectEdgeColor(image, N-1, 2);%����ͼƬ�ߴ�
        [M, N, ~] = size(newI);
        name1 = strcat(name, '0.jpg');
        if(M >= height && N >= width)
            CropCenter(newI, SZ, path, name1);%ȡͼƬ��������
        else
            newI = ReflectEdgeColor(newI, N-1, 2);%����ͼƬ�ߴ�
            [M, N, ~] = size(newI);
            if(M >= height && N >= width)
                CropCenter(newI, SZ, path, name1);%ȡͼƬ��������
            end
        end
        
    elseif((M < 1.5*height) && (N < 1.5*width))
        name1 = strcat(name, '0.jpg');
        CropCenter(image, SZ, path, name1);%ȡͼƬ��������
        
    elseif((M < 1.5*height) && (N > 1.5*width))
        image1 = image(:, 1:width, :);
        name1 = strcat(name, '0.jpg');
        CropCenter(image1, SZ, path, name1);%ȡͼƬ��������
        image1 = image(:, N-width+1:N, :);
        name1 = strcat(name, '1.jpg');
        CropCenter(image1, SZ, path, name1);%ȡͼƬ��������

    elseif((M > 1.5*height) && (N < 1.5*width))
        image1 = image(1:height, :, :);
        name1 = strcat(name, '0.jpg');
        CropCenter(image1, SZ, path, name1);%ȡͼƬ��������
        image1 = image(M-height+1:M, :, :);
        name1 = strcat(name, '1.jpg');
        CropCenter(image1, SZ, path, name1);%ȡͼƬ��������

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
savePath = strcat(path, name);
imwrite(output, savePath);

end

function [] = Crop5Part(I, SZ, path, name)
%% 
[M, N, ~] = size(I);
output = I(1:SZ(1), 1:SZ(2), :);
savePath = strcat(path, name, '1.jpg');
imwrite(output, savePath);

output = I(1:SZ(1), N-SZ(2)+1:N, :);
savePath = strcat(path, name, '2.jpg');
imwrite(output, savePath);

output = I(M-SZ(1)+1:M, 1:SZ(2), :);
savePath = strcat(path, name, '3.jpg');
imwrite(output, savePath);

output = I(M-SZ(1)+1:M, N-SZ(2)+1:N, :);
savePath = strcat(path, name, '4.jpg');
imwrite(output, savePath);

name1 = strcat(name, '0.jpg');
CropCenter(I, SZ, path, name1);


end




