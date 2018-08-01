%function tidData = getTidData()
%%
image_path = 'C:\Users\litao\Desktop\tid2013\distorted_images\';
mosfile_path = 'C:\Users\litao\Desktop\tid2013\mos_with_names.txt';

fileID = fopen(mosfile_path);
C = textscan(fileID,'%f %s');
fclose(fileID);
mos = C{:,1};
mos = mos ./ max(mos);
filename_list = C{:,2};

l = length(mos);
tidData.mos = [];
tidData.image_fullpath = cell(1,l);

for i = 1 : length(filename_list)
    image_fullpath = [image_path filename_list{i}];
    tidData.mos(i) = mos(i);    
    tidData.image_fullpath{i} = image_fullpath;
    tidData.names{i} = filename_list{i};
end

%end