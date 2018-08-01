
X = featureBatch;

[m n p q] = size(X);
for i = 1 : q
    figure(905);
    
    imshow(uint8(squeeze(X(:,:,:,i))));
    
    %colormap(gray);
    title(labelBatch(i));
    pause;
end

aa = res(i).x(:,:,:,1);
f = l.filters(:,:,:,1);
arrayfun(@(x) conv2(aa(:,:,x), ff(:,:,x),'valid' ), 1:3, 'UniformOutput', false);