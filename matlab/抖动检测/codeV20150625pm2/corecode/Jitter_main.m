function [ VideoInf ] = Jitter_main(aviVideo, Mrow, Mcol, EstShift, Thr, SearScop, xNum, yNum)
%%
[frameLen,SearScop] = getInit( aviVideo,SearScop ); % �����������ȼ�����ʵ�֡����������������
startframe = 1+SearScop;
endframe = startframe+frameLen-1;
ImgInf = zeros(endframe-startframe+1,5);
%%
for fNo = startframe : endframe     
    curImg = read(aviVideo, fNo);
    curImg = preProcess(curImg, Mrow, Mcol);
    refNum = 0;
    for fCMP = fNo - 1 : -1 : fNo - SearScop   
        refImg = read(aviVideo, fCMP);       
        refImg = preProcess(refImg, Mrow, Mcol);         
        blockInf  = getBlockInf( curImg,refImg,Mrow, Mcol,xNum,yNum,EstShift); %����ͼ����ƫ��������һά��ˮƽ����ƫ�������ڶ�ά�Ǵ�ֱ����ƫ����
        imageInf  = getImageInf( blockInf);  %���ݿ�ƫ��������ͼ��Ķ����жϡ�����ƫ����            
        if(imageInf(1) ~= 0)
            refNum = fCMP;
            break;
        end        
    end    
    ImgInf(fNo - SearScop,:) = [imageInf,fNo,refNum];   
end

[r, ~] = find(ImgInf(:, 1) == 0);
k = 0;
for i = 1 : length(r)
    del_r = r(i);
    del_r = del_r - k;
    ImgInf(del_r, :) = [];
    k = k + 1;
end
len_arr = length(ImgInf(:, 1));

if len_arr ~= 0
    [jitter_direc, basic_img] = derction(ImgInf);
    ImgInf = posNegDirection(ImgInf, basic_img);
    
    fre_amp = amplitude(ImgInf);%����ͼ����Ϣ������Ƶ�Ķ����жϡ�Ƶ�ʼ�����
else
    jitter_direc = 0;
    fre_amp = [0, 0];
end


VideoInf = [jitter_direc, fre_amp];
end


