function imdb = iPartionDB(imdb, mode)

%%
TRAIN = 1;
PARTION = [0.8, 0.2];

TEST = 2;

%%
len = length(imdb.relPath);

switch mode
    case 'train'
        nTrain = ceil(len * PARTION(1));
        set = ones(1, len, 'single');
        set(nTrain+1 : end) = TEST;
        imdb.set = set;
    case 'test'
        set = repmat(TEST, 1, len);
        imdb.set = set;        
end
end