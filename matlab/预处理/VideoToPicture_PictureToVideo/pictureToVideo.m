function aviobj = pictureToVideo(save_path, dir_name, avi_name)
%%
aviobj = avifile(strcat(save_path, avi_name, '.avi'), 'fps', 1);%creat avi
file_List = getAllFiles( dir_name);

if isempty(file_List);
    error('�趨���ļ�����û���κε�ͼƬ�������¼��...')
end

for i = 1 : length(file_List)
    img_path = file_List{i};
    image = imread( img_path );
    aviobj = addframe(aviobj, image);
    
end
aviobj=close(aviobj);
end
