function  [missreport, falsereport] = missFalseRep(predict_label)
count = 0;
for i = 1 : 22
    if predict_label(i, 1) == -1
        count = count + 1;
    end
end
missreport = count/22;

count = 0;
for i = 23 : 46
    if predict_label(i, 1) == 1
        count = count + 1;
    end
end
falsereport = count/24;
end