%% �޸�ͼƬ���֣�(���)_(����̶�)
image_path = 'E:\caffe-windows-master\data&models\bvlc_alexnet-sur-leafModels\��Ҷ�����Ϣ\�ڵ����س̶�\�ڵ����س̶�������\';
save_path = 'C:\Users\Serissa\Desktop\leafOcclusion\';
path = 'E:\caffe-windows-master\data&models\bvlc_alexnet-sur-leafModels\��Ҷ�����Ϣ\�ڵ����س̶�\�ڵ����س̶�������\�ڵ�����5.xls';
[data, name] =xlsread(path);
score = data(:, 2);
len = length(score(:, 1));
for i =1 : len
    image_name = name{i, 1};
    image = imread(strcat(image_path, image_name));
    
    image_score = score(i, 1);
    add_score = image_score + 0.0001;
    str = num2str(add_score);
    str = strcat(str, '0000001');
    str = str(1:6);
    save_name = strcat(num2str(10000+i), '_', str);
    %if mod(i, 3) == 0 %test
        imwrite(image, strcat(save_path, save_name, '.jpg'));
    %end
    
end





