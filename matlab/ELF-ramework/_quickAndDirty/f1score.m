function f1 = f1score(ma)

%%
rec = ma(1)/(ma(1)+ma(2));
pre = ma(1)/(ma(1)+ma(3));
f1 = (2*rec*pre)/(rec+pre);
end