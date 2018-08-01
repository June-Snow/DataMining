function [  imageInf ] = getImageInf( blockInf )
%% ����ͼ���ƫ��������ͼƬ��������Ϣ��
% �����жϣ�0,1��������0-360�������ȣ�>0��
%%
WminRow = blockInf(:,:,1);
WminCol = blockInf(:,:,2);
[xNum,yNum] = size(WminRow);
%% 
label =  WminRow ~= 0 | WminCol ~= 0;%������ʲôλ�ƣ����������һ������Գ���
imageRow = consisImg( label, WminRow,xNum,yNum ); %���ݿ��ˮƽλ�Ƽ���ͼ��ˮƽλ��һ����
imageCol = consisImg( label, WminCol,xNum,yNum ); %���ݿ�Ĵ�ֱλ�Ƽ���ͼ��ֱλ��һ����
sumFlag = imageRow(1) + imageCol(1);
switch(sumFlag)
    case 0
        imageInf = [0,0,0];
    case 1
        if imageRow(1)==1 %�����ƶ�
            if imageRow(2)<0
                dir = 180;
            else
                dir = 0;
            end
            imageInf = [1,dir,abs(imageRow(2))];
        else %�����ƶ�
            if imageCol(2)<0
                dir = 270;
            else
                dir = 90;
            end
            imageInf = [1,dir,abs(imageCol(2))];
        end            
    case 2 %б���ƶ�
        dir = atan2(imageCol(2),imageRow(2));
        dir = dir*180/pi;
        if dir<0
            dir = dir+360;
        end
        amp = sqrt(imageRow(2)^2 +imageCol(2)^2);
        imageInf = [1,dir,amp];
end
end

