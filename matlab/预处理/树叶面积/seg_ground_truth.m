function seg_ground_truth()

root = 'C:\Users\zhang\Documents\уе╬Э╩т';
ret_dir = 'seg_result';

if ~exist(ret_dir, 'dir')
    mkdir(ret_dir)
end

done_pics = dir(fullfile(ret_dir, '*.bmp'));
done_names = cell(length(done_pics), 1);
for i = 1 : length(done_pics)
    [~, name, ~]= fileparts(done_pics(i).name);
    done_names{i} = name;
end

av_files = dir(fullfile(root, '*.avi'));
for i = 1 : length(av_files)
    [~, namene, ~] = fileparts(av_files(i).name);
    ret = strfind(done_names, namene);
    if ~isempty(cell2mat(ret))
        continue
    end

    obj = VideoReader(fullfile(root, av_files(i).name));
    frame = read(obj, 1);
    v = version('-release');
    if v(4) == '4'
        frame = flipud(frame);    
    end
    bw_gt = interactive_seg(frame, false);
    [~, name, ~] = fileparts(av_files(i).name);
    imwrite(bw_gt, fullfile(ret_dir, [name, '.bmp']));
end

end