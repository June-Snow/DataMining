dir_name = 'C:\Users\Serissa\Desktop\��Ҷ�ڵ�ͼƬ\';
save_path = 'C:\Users\Serissa\Desktop\�쳣ͼƬ\';
file_List = getAllFiles(dir_name);
if isempty(file_List);
    error('�趨���ļ�����û���κ���Ƶ�������¼��...')
end

for i = 1 : length(file_List)
    %%��ȡ��Ƶ
    img_path = file_List{i};
    figure;imshow(img_path);
    [pathstr, name, ext] = fileparts(img_path);
    x = input('s');
    if x == 0
        path = strcat(save_path, name, ext); 
        movefile(img_path, path);
    end
    close all;
end