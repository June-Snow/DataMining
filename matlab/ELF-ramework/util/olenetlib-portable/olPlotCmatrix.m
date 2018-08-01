function olPlotCmatrix(class, confusinoMatrix)

%%
n = length(class);
mat = confusinoMatrix;
imagesc(mat);
colormap(flipud(bone));

textStrings = num2str(mat(:),'%0.2f');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding

%% set zero void
% idx = find(strcmp(textStrings(:), '0.00'));
% textStrings(idx) = {'   '};

%%
[x,y] = meshgrid(1:n);
hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim')); 
textColors = repmat(mat(:) > midValue,1,3);
set(hStrings,{'Color'},num2cell(textColors,2));

set(gca,'XTick',1:length(class),...
        'XTickLabel',class,...
        'YTick',1:length(class),...
        'YTickLabel',class,...
        'TickLength',[0 0]);