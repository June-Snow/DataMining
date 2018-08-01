function iCustomWaitbar(handle, N, left, bottom )

%%
axes(handle);
for x=0:1:N
    xpatch=[0 x x 0];
    ypatch=[0 0 1 1];
    xline=[N 0 0 N N];
    yline=[0 0 1 1 0];
    p=patch(xpatch, ypatch, 'r', 'EdgeColor', 'r', 'EraseMode', 'none');
    l=line(xline, yline, 'EraseMode','none');
    drawnow;
end