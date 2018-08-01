function [vote_error, cmatrix] = cnnVoteError(vote, imdb, ind)

%% cmatrix for confusion matrix
folders = imdb.feature.folderid(ind);
folderind = unique(folders);
fileind = arrayfun(@(x) single(find(imdb.feature.folderid == x)), folderind, 'UniformOutput', false);
assert(numel(cell2mat(fileind)) == numel(ind),...
    ['THE NUM OF THE PATHCH MAY NOT COMPLATE THE WHOLE IMAGES '...
    'YOU MAY CONSIDER TO USE THE SENTENCE LIKE THIS: '...
    'imdb.features.set(imdb.features.folderid<=2) = 1']);
gt =  cell2mat(cellfun(@(x) imdb.feature.label(x(1)), fileind,  'UniformOutput', false));% ground truh
pred = arrayfun(@(x) gather(stat(folders,vote, x)), folderind);%,  'UniformOutput', false
vote_error = sum((pred-gt)~=0)/length(folderind);

%-----block confusion matrix-----
targets = zeros(max(imdb.feature.label), length(ind), 'single');
outputs = zeros(max(imdb.feature.label), length(ind), 'single');
targets( ((1:length(ind))-1) * max(imdb.feature.label) + imdb.feature.label(ind) ) = 1; 
outputs( ((1:length(ind))-1) * max(imdb.feature.label) + vote) = 1;
[cmatrix_block.cvalue, cmatrix_block.cm, cmatrix_block.ind, cmatrix_block. per] = confusion(targets,outputs);
cmatrix_block.targets = targets;
cmatrix_block.outputs = outputs;

%-----whole image confusion matrix-----
targets = zeros(max(imdb.feature.label), length(gt), 'single');
outputs = zeros(max(imdb.feature.label), length(pred), 'single');

targets( ((1:length(gt))-1) * max(imdb.feature.label) + gt ) = 1; 
outputs( ((1:length(pred))-1) * max(imdb.feature.label) + pred ) = 1;
[cmatrix_whole.cvalue, cmatrix_whole.cm, cmatrix_whole.ind, cmatrix_whole.per] = confusion(targets,outputs);
cmatrix_whole.targets = targets;
cmatrix_whole.outputs = outputs;

cmatrix.cmatrix_b = cmatrix_block;
cmatrix.cmatrix_w = cmatrix_whole;
cmatrix.meta = imdb.meta.class;

fprintf('cmatrix_block.cm : \n');disp(cmatrix_block.cm);
fprintf('cmatrix_whole.cm : \n');disp(cmatrix_whole.cm);


% TODO: Document IT !!!!
function pred = stat (folders, vote, folderind)
label_stat = tabulate(vote(folders == folderind));
[~, pred] = max(label_stat(:,3), [], 1);
