function [data_set, data_label] = trainTestSet(data_s, data_n, label_s, label_n)

len_col_s = length(data_s(:, 1));
len_col_n = length(data_n(:, 1));
len_row_n = length(data_n(1, :));

data_set = zeros(len_col_s+len_col_n, len_row_n);
data_set(1:len_col_s, :) = data_s(1:len_col_s, :);
data_set(len_col_s+1:len_col_s+len_col_n, :) = data_n(1:len_col_n, :);

data_label = zeros(len_col_s+len_col_n, 1);
data_label(1:len_col_s, 1) = label_s(1:len_col_s, 1);
data_label(len_col_s+1:len_col_s+len_col_n, 1) = label_n(1:len_col_n, 1);
end