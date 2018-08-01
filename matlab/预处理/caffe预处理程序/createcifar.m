%解析cifar-10数据matlab代码 cifar网址：http://www.cs.toronto.edu/~kriz/cifar.html
%这只是一个简单的数据解析代码，你首先应设置一个全局变量 number=[1,...1];10个1
%由于时间紧迫，这个代码并没有考虑简洁性问题，但是更加容易理解。

% createcifar.m
% @param phase = ‘train’  or ‘test’ 
% @param number is a vector ; length = 10 ;records number of each class image imwrited 
function [number] = createcifar(phase,number,data,labels,resize_method)
   for index = 1:10000
    % all matlab loop variables change from 1 not 0!  
    % include channels of an image
    pixelr = data(index,1:1024);
    pixelg = data(index,1025:2048);
    pixelb = data(index,2049:3072);
    class = labels(index);
    for line = 1:32
        image(line,:,1)=(pixelr(1,(line-1)*32+1:line*32));
        image(line,:,2)=(pixelg(1,(line-1)*32+1:line*32));
        image(line,:,3)=(pixelb(1,(line-1)*32+1:line*32));
    end
        result = imresize(image,[96, 96],resize_method);
    switch(class)
        case 0                  %note this part can be replaced a variable 'PATH'
            imwrite(result,char([phase,'\airplane\',num2str(number(1)),'.jpg']));
            number(1) = number(1)+1;
        case 1
            imwrite(result,char([phase,'\automobile\',num2str(number(2)),'.jpg']));
            number(2) = number(2)+1;
        case 2
            imwrite(result,char([phase,'\bird\',num2str(number(3)),'.jpg']));
            number(3) = number(3)+1;
        case 3
            imwrite(result,char([phase,'\cat\',num2str(number(4)),'.jpg']));
            number(4) = number(4)+1;
        case 4
            imwrite(result,char([phase,'\deer\',num2str(number(5)),'.jpg']));
            number(5) = number(5)+1;
        case 5
            imwrite(result,char([phase,'\dog\',num2str(number(6)),'.jpg']));
            number(6) = number(6)+1;
        case 6
            imwrite(result,char([phase,'\frog\',num2str(number(7)),'.jpg']));
            number(7) = number(7)+1;
        case 7
            imwrite(result,char([phase,'\horse\',num2str(number(8)),'.jpg']));
            number(8) = number(8)+1;
        case 8
            imwrite(result,char([phase,'\ship\',num2str(number(9)),'.jpg']));
            number(9) = number(9)+1;
        case 9
            imwrite(result,char([phase,'\truck\',num2str(number(10)),'.jpg']));
            number(10) = number(10)+1;
    end
   end
end

