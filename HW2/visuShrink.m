function lambda = visuShrink(C, img)
N = numel(img);
sigma_N = median(abs(C(:))) / 0.6745;
lambda = sigma_N * sqrt(2*log(N));
end