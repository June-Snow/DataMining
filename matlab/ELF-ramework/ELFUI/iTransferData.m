function iTransferData(label, pred, rawDataDir, path, mode)

%%
dstDir = 'D:\STUDY\[1] ÕºœÒ¥¶¿Ì\Database\ ”∆µø‚ 4.0-normalfalse';
nSample = length(label);
for i = 1 : nSample
    if pred(i) ~= label(i)
        [dirStr, nameStr, ext] = fileparts(path{i});
        source = fullfile(rawDataDir, path{i});
        
        dstDirDetail = fullfile(dstDir, num2str(label(i)), num2str(pred(i)));
        destination = fullfile(dstDirDetail, [nameStr, '.avi']);  
        if ~exist(source, 'file')
            warning('%s does not exist\n', source);
            continue;
        end
        
        if exist(destination, 'file')
            destination = fullfile(dstDirDetail, [nameStr, datestr(now, 30), '.avi']);       
        end
        
        if ~exist(dstDirDetail, 'dir')
            mkdir(fullfile(dstDirDetail)); 
        end
        
        disp(sprintf('processing %s', source));
        switch mode
            case 1 %'copy'
                copyfile(source, destination);
            case 2 %'move'
                movefile(source, destination);
            case 3 % 'delete'
                delete(source);
            otherwise
                errStr = fprintf('%s didnt input mode correctly\n', source);
                error(errStr);
        end
    end
end
end