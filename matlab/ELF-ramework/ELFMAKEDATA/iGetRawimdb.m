function [rawImdb] = iGetRawimdb(rawDataDir, targetfolder, ext, trainType)

%%

folder = targetfolder;
nf = length(folder);
rawImdb = iInitRawimdb();

count = 1;
relPath = [];
label = [];
if trainType == 1
    for i = 1 : nf
        flist = olGetAllFile(fullfile(rawDataDir, folder{i}), 'ext', olStdExt(ext));
        nfile = length(flist);
        for j = 1 : nfile
            relPath{count}  = olCvtRelativePath(rawDataDir, flist{j});
            label(count) = i;
            count = count + 1;
        end
    end
end

if trainType == 2
    for i = 1 : nf
        path = strcat(rawDataDir, '\', folder{i}, '\·ÖÊý.xls');
        [data, num] = xlsread(path);
        maxVal = max(data(:));
        minVal = min(data(:));
        diffVal = maxVal - minVal;
        len = length(data);
        for j = 1 : len
            path = strcat(fullfile(rawDataDir, folder{i}), '\', num{j});
            if exist(path, 'file')
                relPath{count}  = olCvtRelativePath(rawDataDir, path);
                label(count) = (data(j)-minVal)/diffVal;
                count = count + 1;
            end
        end
    end
end

len = length(relPath);
ind = randperm(len);

rawImdb.class = folder;
rawImdb.rawDataDir = rawDataDir;
rawImdb.relPath = relPath;
rawImdb.label = label;
% rawImdb.relPath = relPath(ind);
% rawImdb.label = label(ind);

end
