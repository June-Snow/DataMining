%%
clear all
clc
%%
for k = 1:1
    if( k==1 )
        foldername = 'F:\LIVE';
    else
        foldername = 'F:\tid2013';
    end
    p = genpath(foldername);    % 获得文件夹data下所有子文件的路径，这些路径存在字符串p中，以';'分割
    length_p = size(p,2);       %字符串p的长度
    path = {};                  %建立一个单元数组，数组的每个单元中包含一个目录
    temp = [];
    for i = 1:length_p          %寻找分割符';'，一旦找到，则将路径temp写入path数组中
        if p(i) ~= ';'
            temp = [temp p(i)];
        else
            temp = [temp '\'];  %在路径的最后加入 '\'
            path = [path ; temp];
            temp = [];
        end
    end
    
    subDir = path(2:end);
    
    %%
    clear p length_p temp;
    
    %%
    file_num = size(subDir ,1);% 子文件夹的个数
    count = 0;
    label = 1;
    %     ind =1;
    
    for i = 1:file_num
        file_path =  subDir{i}; % 图像文件夹路径
        save_path = strcat('G',file_path(2:end));   %存储路径
        
        if ~isdir(save_path)
            mkdir(save_path);
        end
        save_path_32 = strcat(save_path,'32\');
        if ~isdir(save_path_32)
            mkdir(save_path_32);
        end
        save_path_64 = strcat(save_path,'64\');
        if ~isdir(save_path_64)
            mkdir(save_path_64);
        end
        save_path_128 = strcat(save_path,'128\');
        if ~isdir(save_path_128)
            mkdir(save_path_128);
        end
        save_path_256 = strcat(save_path,'256\');
        if ~isdir(save_path_256)
            mkdir(save_path_256);
        end
        
        ImageCutAndSave(file_path, save_path, 32, label);
        
    end
    label = label + 1;
end


