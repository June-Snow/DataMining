%% ����proto�ļ��Ű������
type = 1;
%������
if type
    dir_name = 'C:\Users\Serissa\Desktop\��Ҷ�ڵ�ͼƬ\';
    saveTextPath = 'D:\Project\caffe-windows-master-zhangjunhui\data\blur5000-\normal.txt';
    file_List = getAllFiles(dir_name);
    if isempty(file_List);
        error('�趨���ļ�����û���κ���Ƶ�������¼��...')
    end
    
    for i = 1 : length(file_List)
        %%��ȡ
        img_path = file_List{i};
        [pathstr, name, ext] = fileparts(img_path);
        dataStr{i, 1} = strcat(name, ext);
    end
    fp = fopen(saveTextPath,'wt');
%    fprintf(fp, 'filelist {\r\n  root: "C:/root_path/"\n');%\r
    len = length(file_List);
    for i =1 : len
%         fprintf(fp, 'file {\n');%\r
%         str = strcat('name: "normal/"',dataStr{i, 1}, '""\n');%\r
%         fprintf(fp, str);
%         fprintf(fp, 'gold_score: 1.0\n');%\r
%         fprintf(fp, '}\n');%\r
        str = strcat(dataStr{i, 1}, '"',num2str(1),'\r\n');%\n
        fprintf(fp, str);     
    end
%    fprintf(fp, '}\n');%\r
    fclose(fp);
else
    %�ڵ���
    textPath = 'C:\Users\litao\Desktop\��Ҷ�ڵ�ͼƬ\leaf.txt';
    [imgData] = importdata(textPath);
    len = length(imgData(:, 1));
    dataStr = cell(len, 2);
    valNum = zeros(len, 1);
    for i = 1 : len
        imgStr = imgData{i,1};
        pos =strfind(imgStr,'"');
        dataStr{i, 1} = imgStr(1 : single(pos(1))-1);
        val = imgStr(single(pos(1))+1 : end);
        val = str2double(val);
        valNum(i, 1) = val;
    end
    valMin = min(valNum);
    valMax = max(valNum);
    
    for i = 1 : len
        val = (valNum(i, 1) - valMin)/(valMax - valMin);%����һ��0 1 ֮�䣩
        %val = 0.1 + (valNum(i, 1) - valMin)/(valMax - valMin)*(0.9 - 0.1);%����һ��0.1-0.9֮�䣩
        valNum(i, 1) = 1 - val;
    end
    saveTextPath = 'C:\Users\litao\Desktop\��Ҷ�ڵ�ͼƬ\proto.txt';
    fp = fopen(saveTextPath,'wt');
    %fprintf(fp, 'filelist {\r\n  root: "C:/root_path/"\n');%\r
    
    for i =1 : len
%         fprintf(fp, 'file {\n');%\r
%         str = strcat('name: "gray/"',dataStr{i, 1}, '""\n');%\r
%         fprintf(fp, str);
%         str = strcat('gold_score: ', num2str(valNum(i, 1)), '\n');%\r
%         fprintf(fp, str);       
%         fprintf(fp, '}\n');%\r
        str = strcat(dataStr{i, 1}, '"',num2str(valNum(i, 1)),'\r');%\n
        fprintf(fp, str);  
    end
    %fprintf(fp, '}\n');%\r
    fclose(fp);
end

