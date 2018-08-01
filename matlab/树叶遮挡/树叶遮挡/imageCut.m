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
    p = genpath(foldername);    % ����ļ���data���������ļ���·������Щ·�������ַ���p�У���';'�ָ�
    length_p = size(p,2);       %�ַ���p�ĳ���
    path = {};                  %����һ����Ԫ���飬�����ÿ����Ԫ�а���һ��Ŀ¼
    temp = [];
    for i = 1:length_p          %Ѱ�ҷָ��';'��һ���ҵ�����·��tempд��path������
        if p(i) ~= ';'
            temp = [temp p(i)];
        else
            temp = [temp '\'];  %��·���������� '\'
            path = [path ; temp];
            temp = [];
        end
    end
    
    subDir = path(2:end);
    
    %%
    clear p length_p temp;
    
    %%
    file_num = size(subDir ,1);% ���ļ��еĸ���
    count = 0;
    label = 1;
    %     ind =1;
    
    for i = 1:file_num
        file_path =  subDir{i}; % ͼ���ļ���·��
        save_path = strcat('G',file_path(2:end));   %�洢·��
        
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


