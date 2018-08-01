m = size(randLabel, 2);
for i = 1 : m
    figure(905);
    imagesc(randFeature{i}{:});
    colormap(gray);
    title(randLabel(i));
    pause;
end
