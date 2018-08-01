data=zeros(170,170,3,length(featImdb.feature));
for i = 1 : length(featImdb.feature)
    data(:,:,:, i ) = single(featImdb.feature{i}{1}); 
end
imdb.images = [];
imdb.images.labels = featImdb.label;
meanImg = mean(data, 4);
imdb.images.data = single(bsxfun(@minus, data, meanImg));

imdb.images.set = featImdb.set;
save('msraimdb.mat', 'imdb')