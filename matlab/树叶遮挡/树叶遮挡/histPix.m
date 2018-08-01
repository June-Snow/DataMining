src = 'C:\Users\litao\Desktop\�½��ļ��� (2)\03608\';
files = dir(strcat(src,'*.jpg'));
for i = 1 : length(files);
    I = imread(strcat(src, files(i).name));
    name = regexp(files(i).name,'\.', 'split');
    [m n c]=size(I);
    if(c==3) %RGB pic        
        fid = fopen(strcat('C:\Users\litao\Desktop\�½��ļ��� (2)\03608\',name{1},'.txt'),'w');
        for i = 1:m
            for j=1:n
                fprintf(fid,'%d,%d,%d\t',I(i,j,1),I(i,j,2),I(i,j,3));
            end
            fprintf(fid,'\n');
        end
        fclose(fid);
    end
    h = figure;
    subplot(1,2,1);imshow(I);
    subplot(1,2,2);
    siz = size(I);
    I1=reshape(I,siz(1)*siz(2),siz(3));  % ÿ����ɫͨ����Ϊһ��
    I1=double(I1);
    [N,X]=hist(I1,[0:1:255]);    % �����ҪС���ο�һ�㣬���������ٵ㣬���԰Ѳ����Ĵ󣬱���0:5:255
    bar(X,N(:,[3 2 1]));    % ����ͼ����N(:,[3 2 1])����ΪĬ�ϻ�ͼ��ʱ����õ���ɫ˳��Ϊb,g,r,c,m,y,k����ͼƬ��rgb˳�������෴�����԰�ͼƬ�е�˳�򵹹�������ͼƬ��ɫͨ��������ʱ����ɫһ��
    xlim([0 255])
    hold on 
    plot(X,N(:,[3 2 1]));    % �ϱ߽�����
    hold off
    saveas(h,strcat('C:\Users\litao\Desktop\�½��ļ��� (2)\03608\', name{1}, '.jpg'));
end
    
