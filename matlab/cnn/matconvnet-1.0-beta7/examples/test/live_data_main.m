clc;
clear all;

root = 'T:\LIVE\'; 
folder_list = {'fastfading','gblur','jp2k','jpeg','wn'};
for i = 1 : length(folder_list)
    display(['processing folder', folder_list{i}]);
    if ~exist([root, folder_list{i}], 'dir')
        continue
    end
    [images meta] = make_data_live([root folder_list{i}]);
    save(['live-mat' num2str(i) '.mat'], 'meta', 'images');
end

display('done');