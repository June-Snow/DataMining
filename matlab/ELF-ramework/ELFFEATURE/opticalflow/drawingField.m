function [] = drawingField(f,scale, upper,low,left,right,singularModel)

%%
s = size(f);
step = max(s / scale);

[X, Y] = meshgrid(1:step:s(2), s(1):-step:1);

U = interp2(f(:, :, 1), X, Y);
V = interp2(f(:, :, 2), X, Y);
quiver(X, Y, U, V, 1, 'b', 'LineWidth', 1);
% set(h,'ShowArrowHead', 'off') %È¡Ïû¼ýÍ·
set(gca,'YDir','reverse', 'FontSize', 13);
axis image;

if (nargin > 2)
    if (strcmp(singularModel,'spot'))
        shapeA = 1;
    else
        shapeA = 0;
    end
    shapeB = 1;
    rectangle('Position',[left,upper,right-left,low-upper],'LineWidth',2,'Curvature',[shapeA,shapeB],'edgecolor','r');
end

end