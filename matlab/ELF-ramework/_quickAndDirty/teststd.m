% test std
clear
n=10;
v = rand(10,10,n);
sv = std(v, 0, 3);

vmean = mean(v, 3);
v1 = bsxfun(@minus, v(:,:,1:5), vmean );
v2 = bsxfun(@minus, v(:,:,6:end), vmean );

v3 = cat(3, v1, v2);
v3 = sum(v3.^2, 3);
stdCalc = sqrt((v3) / (n-1));

sv_ = reshape(sv, 1, []);
stdCalc_ = reshape(stdCalc, 1, []);
err = sum((sv_-stdCalc_).^2);
fprintf('err %f\n', err);

