imdb_path = '.\data\live-baseline\imdb-3232rgb-live-scorechange.mat';
imdb = load(imdb_path)
l = length(imdb.images.name);
ind = randperm(l);
imdb.images.name = imdb.images.name(ind);
imdb.images.scores = imdb.images.scores(ind);
imdb.images.id = imdb.images.id(ind);


imdb.images.set(1:ceil(0.6*l)) = 1;
imdb.images.set(ceil(0.6*l)+1:ceil(0.6*l+0.4*0.2*l)) = 2;
imdb.images.set(ceil(0.6*l+0.4*0.2*l)+1:end) = 3;

save([imdb_path '1'], '-struct', 'imdb');      