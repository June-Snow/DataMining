function labelPic(videoPath, pred, className, sep)

%% 标记图片中树叶与正常区域

if nargin == 3
    sep = sqrt(length(pred));
end

img = olReadDataToImg(videoPath{1});

predS = reshape(pred, [sep sep]);
[M, N, ~] = size(img);
MB = round(M/6);
NB = round(N/14);

o = ones(floor(M/sep), floor(N/sep));
mask = kron(predS', o);

m_ = mask;
t = unique(mask(:));
result = zeros(size(m_));
curnum = 0;
for i = 1: length(t)
    curImg = bwlabel(m_== t(i));
    for j = 1 : max(curImg(:))
        curImg(curImg==j) = curnum+j;
    end
    curnum = curnum+length(unique(curImg))-1;
    result = result+curImg;
end

centroids = [];
t = unique(result(:));
for i = 1:length(t)
    [row, col] = find(result == t(i));
    mid = find(row == row(1));
    num = mid(2) - mid(1);
    centroids = cat(1, centroids, [row(MB), col(NB*num)]);
end

figure(906);
imagesc(mask);colormap(hot);colorbar;hold on
plot( centroids(:,2), centroids(:,1),'b*');
for i = 1 : size(centroids, 1)
    label = mask(ceil(centroids(i,1)), ceil(centroids(i,2)), 1);
    text(centroids(i,2), centroids(i,1),...
        [num2str(label), ':' className{label}],...
        'BackgroundColor',[.7 .9 .7]);
end
hold off;

result3D = repmat(result, [1,1,3]);
[M, N, ~] =size(result3D);
img = imresize(img, [M N]);
synImg = (double(img) + (result3D) * 50) ;
synImg = synImg / (max(result3D(:))/255);
figure(907);
imagesc(synImg/max(synImg(:)));hold on
for i = 1 : size(centroids, 1)
    label = mask(ceil(centroids(i,1)), ceil(centroids(i,2)), 1);
    text(centroids(i,2)+4, centroids(i,1),...
        [num2str(label), ':' className{label}],...
        'BackgroundColor',[.7 .9 .7]);
end
plot( centroids(:,2), centroids(:,1),'r.', 'MarkerSize',6);
hold off;

end


