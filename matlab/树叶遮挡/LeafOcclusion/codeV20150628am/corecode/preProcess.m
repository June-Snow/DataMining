function [Img] = preProcess(Img, M, N)
%%

[row, col, ~] = size(Img);
if (row ~= M || col~= N)
    Img = imresize(Img, [M N]);
end

end