clear; close all; clc;
load("Q2_image.mat")
multi = cat(3, img, img_n);
montage(multi)
%% part b
img_den1 = TVL1denoise(img_n, 1, 100);
multi = cat(3, img_n, img_den1, img);
montage(multi, "Size", [1, 3])
title("TV with $$L^1$$ regularization: noisy image (left), denoised image (middle), original image (right)", "Interpreter","latex")
%% part c
SNR = 10 * log10(sum(img .^ 2, "all") / sum((img - img_den1) .^2, "all"));
epi1_n = EPI(img, img_n, 1);
epi1_den = EPI(img, img_den1, 1);
str = "SNR = " + num2str(SNR);
disp(str)
str = "using 2nd formulation: EPI = " + num2str(epi1_n) + " (noisy image)";
disp(str)
str = "using 2nd formulation: EPI = " + num2str(epi1_den) + " (denoised image)";
disp(str)