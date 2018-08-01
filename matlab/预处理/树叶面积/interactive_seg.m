function totMask = interactive_seg(img, isshow)
p = rgb2gray(img);
imshow(p);
sz = size(p);
totMask = false( sz ); % accumulate all single object masks to this one
h = imfreehand( gca ); setColor(h,'red');
position = wait( h );
BW = createMask( h );
while sum(BW(:)) > 10 % less than 10 pixels is considered empty mask
      totMask = totMask | BW; % add mask to global mask
      % you might want to consider removing the old imfreehand object:
      %delete( h ); % try the effect of this line if it helps you or not.

      % ask user for another mask
      h = imfreehand( gca ); setColor(h,'red');
      position = wait( h );
      BW = createMask( h );
end

if isshow == true
    % show the resulting mask
    figure; imshow( totMask ); title('multi-object mask');
end

end