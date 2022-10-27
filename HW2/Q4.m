%% load images
clear; close all; clc;
img = rgb2gray(imread("covid.png"));
figure;
imshow(img)
%% part a
[cA,cH,cV,cD] = dwt2(img, "haar");
lamda_cH = visuShrink(cH, img);
lamda_cV = visuShrink(cV, img);
lamda_cD = visuShrink(cD, img);
% using different thr for each subband
cH_new = wthresh(cH, "s", lamda_cH);
cV_new = wthresh(cV, "s", lamda_cV);
cD_new = wthresh(cD, "s", lamda_cD);
%% part b
img_den = idwt2(cA, cH_new, cV_new, cD_new, "haar");
figure;
subplot(121)
imshow(img)
title("noisy image", "Interpreter","latex", "FontSize", 20)
subplot(122)
imshow(uint8(img_den))
title("denoised image (using DWT)", "Interpreter","latex", "FontSize", 20)
%% part c
I = fft2(img);
Ivec = reshape(I, 1, numel(I));
Iabs = abs(Ivec).^2;
Isorted = sort(Iabs, "descend");
thr = 1e7;
Ivec_new = (Iabs >= thr) .* Ivec;
I_new = reshape(Ivec_new, size(img));
img_den = ifft2(I_new);
figure;
subplot(121)
imshow(img)
title("noisy image", "Interpreter","latex", "FontSize", 20)
subplot(122)
imshow(uint8(img_den))
title("denoised image (using DFT)", "Interpreter","latex", "FontSize", 20)
















