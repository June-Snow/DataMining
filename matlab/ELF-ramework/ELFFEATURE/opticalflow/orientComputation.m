function orientImg = OFOrientComputation(U, V, blocksigma, smoothsigma)

%%
% Covariance data for optical flow
Gxx = U .^2;
Gxy = U .* V;
Gyy = V .^2;

% Smooth the covariance data to perform a weighted summation of the data.
h0 = gaussianConstruction(blocksigma);
Gxx = filter2(h0, Gxx);
Gxy = 2*filter2(h0, Gxy);
Gyy = filter2(h0, Gyy);

%%
% Analytic solution of principal direction
denom = sqrt(Gxy.^2 + (Gxx - Gyy).^2) + eps;
sin2theta = Gxy./denom;            
cos2theta = (Gxx-Gyy)./denom;

%%
h1 = gaussianConstruction(smoothsigma);
cos2theta = filter2(h1, cos2theta); % Smoothed sine and cosine
sin2theta = filter2(h1, sin2theta); % doubled angles

%%
orientImg = atan2(sin2theta,cos2theta);

end