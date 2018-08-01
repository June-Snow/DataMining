function  [train_set, train_label, test_set, test_label] = dataSet(START, FILEDIR, FILEEXT, Mrow, Mcol, FrameLen, Tol, Thr, xNum, yNum, rate, label)
%% 
FILES    = dir(fullfile(FILEDIR, FILEEXT));
FILENUM  = size(FILES, 1);
data_set = zeros(FILENUM, 81);
for i = START : START+FILENUM-1
    filename  = [FILEDIR, FILES(i,1).name];
    disp(['Now processing video:', filename]);
    aviVideo  = VideoReader(filename);        % 读取.avi格式视频文件
    VideoInf = getVideoFeature(aviVideo, Mrow, Mcol,FrameLen,Tol,Thr,xNum,yNum);
    data_set(i, :) = VideoInf;
end
train_set(1 : fix(FILENUM*rate), :) = data_set(1 : fix(FILENUM*rate), :);
test_set( : , :) = data_set(fix(FILENUM*(rate)) + 1: FILENUM, :);

train_label = zeros(fix(FILENUM*rate), 1);
test_label = zeros(fix(FILENUM*(1-rate)) + 1, 1);
train_label(:, 1) = label;
test_label(:, 1) = label;
end

