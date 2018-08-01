function make_data_live_gbdt()
addpath('.\getbatchwrapper');
imdb = load(fullfile('.\data\live-baseline','imdb-3232rgb-live.mat'));

opts.imageSize = [32, 32, 3] ;
opts.interpolation = 'bicubic' ;
opts.averageImage = [] ;
opts.batchsize = 256;
opts.imagemode = 'gray';

train = find(imdb.images.set == 1) ;
test = find(imdb.images.set == 1) ;
val = find(imdb.images.set == 3);

bs = opts.batchsize;
fn = elfGetBatchWrapper(opts);

h=waitbar(0,'´ý¤Ã¤Æ£¬Ó‹Ëã¤¹¤ë');

%train----------------------------------------------------------------------
fid = fopen('gbdt-train.txt', 'w');
fid_id = fopen('gbdt-train-id.txt', 'w');
for t = 1 : bs : numel(train)    
    batch = train(t:min(t+bs-1, numel(train))) ;
    fprintf('computing average image: processing batch starting with image %d ...', batch(1)) ;
    [images scores ids] = fn(imdb, batch) ;    
    waitbar(t/numel(test),h,'´ý¤Ã¤Æ');
    for i = 1 : length(images)
        img = images(:,:,:,i);
        get_gbdt_format(fid, fid_id, img, scores(i), ids(i), opts);
    end

end
fclose(fid);
fclose(fid_id);

%test----------------------------------------------------------------------
fid = fopen('gbdt-test.txt', 'w');
fid_id = fopen('gbdt-test_id.txt', 'w');
for t = 1 : bs : numel(test)
    batch = test(t:min(t+bs-1, numel(train))) ;
    fprintf('computing average image: processing batch starting with image %d ...', batch(1)) ;
    [images scores ids] = fn(imdb, batch) ;    
    waitbar(t/numel(test),h,'´ý¤Ã¤Æ');
    for i = 1 : length(images)
        img = images(:,:,:,i);
        get_gbdt_format(fid, fid_id, img, scores(i), ids(i), opts);
    end
end
fclose(fid);
fclose(fid_id);

%val----------------------------------------------------------------------
fid = fopen('gbdt-val.txt', 'w');
fid_id = fopen('gbdt-val_id.txt', 'w');
for t = 1 : bs : numel(test)
    batch = val(t:min(t+bs-1, numel(train))) ;
    fprintf('computing average image: processing batch starting with image %d ...', batch(1)) ;
    [images scores ids] = fn(imdb, batch) ;    
    waitbar(t/numel(test),h,'´ý¤Ã¤Æ');
    for i = 1 : length(images)
        img = images(:,:,:,i);
        get_gbdt_format(fid, fid_id, img, scores(i), ids(i), opts);
    end
end
fclose(fid);
fclose(fid_id);

waitbar(1,h,'Íê³É¤·¤¿');

%--------------------------------------------------------------------------
function get_gbdt_format(fid_data, fid_id, img, score, id, opts)
%--------------------------------------------------------------------------
if strcmp(opts.imagemode, 'gray')
    img = rgb2gray(uint8(img));
end
line = procData4ML(img, score, 'type', 'whole');
fprintf(fid_data, line);
fprintf(fid_id, [num2str(id), '\n']);