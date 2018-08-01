fid = fopen('D:\STUDY\[0] ELF-ramework\ELF-ramework\ELF-ramework\_expData\20150703T100228\data.txt');
A = textscan(fid, '%d %d %f %f %s\n');
fclose(fid);

fid2 = fopen('D:\STUDY\[1] 图像处理\Database\曹斌文数据-树叶遮挡\树叶遮挡.txt');
B = textscan(fid2, '%s %f %s');
fclose(fid);

corr(A{4}, (B{2}-min(B{2}))/(max(B{2}) - min(B{2})))

[sA, ind] = sort(A{4}, 'descend');
sname = A{5}(ind);
for i = 1 : 3 :length(sname)
    videoPath = ['D:\STUDY\[1] 图像处理\Database\曹斌文数据-树叶遮挡', sname{i}];
    aviObj = VideoReader(videoPath);
    img = read(aviObj, 1);
    imshow(img);
    pause();
end