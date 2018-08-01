%%
% ���ܣ�����ʵ���˽����ͼƬת��ΪAVI��ʽ
% ˵����1.����ѡ���Ƿ��ͼƬ����Ԥ�������ͼƬ���ǳߴ���ͬ��ͼƬ��ʽ��ͬ��
%         ��ô����ֱ��������һ��,�����ͼƬ����Ԥ�������
%       2.���裺
%          step1: ��������
%          step2: ����Ŀ���ļ����µ�����ͼƬ,��ͼƬ��·����Ϣ����Ϊ�ṹ��
%          step3: �����趨�Ĳ�����ȡͼƬ��������Ԥ�������
%          step4: �õ�ͼƬ��Ϣ,ת��ΪAVI,�����б���


%% step1:����������

clear 
clc
disp('��һ������������������...................')

%������ͼƬ�Ĵ���ļ��У����Դ������ļ��е����
dirName = 'D:\MATLAB\work\Study\DATA';

%�������ļ��еĴ��λ�ã����Բ����ڣ�������Զ�����
desName = 'D:\MATLAB\work\Study\PDATA';

%����ͼƬ�Ĺ�һ���ߴ�
thesizex = 500;thesizey=500; thesizez=3; ischangeszie = 0;

%����RGB����ֱ��ʹ��Gray��ͼƬ
imagetype = 'Gray';

%ͼƬ��ͨ�ø�ʽ����
fmt = '.bmp';

%% step2:����Ŀ���ļ����µ�����ͼƬ,��ͼƬ��·����Ϣ����Ϊ�ṹ��
disp('�ڶ�������ȡ�ļ��������е�ͼ���ļ�...................')

%ע�⣺��Ҫ�ڴ��ļ����·��������͵��ļ�������ᱨ��
%��ȡ�ļ��������е��ļ�
fileList = getAllFiles(dirName);

%% step3: ��ʼ��ͼƬ����Ԥ�������
disp('����������ʼ�Զ�ÿһ��ͼƬ���д���...................')

%ͼƬ����Ŀ
img_num = length(fileList);

if img_num ==0;
    error('�趨���ļ�����û���κε�ͼƬ�������¼��...')
end

for i = 1:img_num %��ʼ����
    imgname = fileList{i};
    I_img = imread(imgname);
    
    %ת��Ϊ�Ҷ�ͼ
    [sizex,sizey,sizez] = size(I_img);
    if sizez ==3&&strcmp(imagetype,'Gray')
        I_img = rgb2gray(I_img);
        thesizez = 1;
    end
    
    if i==1
        disp(strcat('��ǰ�ߴ緶ΧΪ: ',num2str(sizex),' *',num2str(sizey),';\n'));
    elseif (i==1)&&(ischangeszie==1)
        disp(strcat('�ֽ�����ͼƬת��Ϊ��',num2str(thesizex),'*',num2str(thesizey)));
        ischange = input('�Ƿ�Ա任�ߴ���и��ģ���(1) ��(0)');
        if ischange ==1
            thesizex = input('�������һ��ͼ��ĸ߶ȣ�');
            thesizey = input('�������һ��ͼ��Ŀ�ȣ�');
        end
    elseif (i==1)&&(ischangeszie==0)
        disp('������ͼ��ĳߴ�任');
    end
    
    %���гߴ�Ĺ�һ������
    if ischangeszie==1
        I_img = imresize(I_img,[thesizex,thesizey],'bilinear');
    end
    
    %�Դ����ͼƬ����ͳһ�����ı���
    if i==1
        if not(exist(desName,'dir'))
            mkdir(desName);
        end
    end
    imwrite(I_img,strcat(desName,'\',num2str(i),fmt),fmt(2:end));
end
clear ii I_img sizex sizey sizez fileList 

%% step4: �õ�ͼƬ��Ϣ,ת��ΪAVI,�����б���

%��ȡ�ļ��������е��ļ�
fileList = getAllFiles(desName);

%ͼƬ����Ŀ
img_num_out = length(fileList);

if img_num_out ==0|| img_num_out~=img_num
    error('�趨���ļ����ڵ�ͼƬ���������˴��������¼��...')
end

%����һ��AVI��ʽ������,���ڱ���ͼ��������Ϣ
aviobj = avifile('mymovie.avi','fps',1);

%Mdata = zeros(thesizex,thesizey,thesizez,img_num_out,'uint8');
for i=1:img_num_out
    %Mdata(:,:,:,i)=imread(fileList{i});
    Mdata = imread(fileList{i});
    imshow(Mdata)
    frame = getframe(gca);
    aviobj = addframe(aviobj,frame);
end
aviobj = close(aviobj);

