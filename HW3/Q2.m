%% part a
clear; close all; clc;
img = phantom('Modified Shepp-Logan', 700);
img_n = imnoise(img, 'salt & pepper', 0.03);
multi = cat(3, img, img_n);
montage(multi)
title("original image (left), noisy image (right)", "Interpreter","latex")
%% part b
img_den1 = anisodiff(img_n, 25, 90, 0.1, 1);
% img_den2 = anisodiff(img_n, 25, 50, 0.1, 2);
multi = cat(3, img_n, img_den1, img);
montage(multi, "Size", [1 3])
title("Anisotropic Diffusion Filter: noisy image (left), denoised image (middle), original image (right)", "Interpreter","latex")
%% part c
SNR = 10 * log10(sum(img .^ 2, "all") / sum((img - img_den1) .^2, "all"));
epi0_n = EPI(img, img_n, 0);
epi1_n = EPI(img, img_n, 1);
epi0_den = EPI(img, img_den1, 0);
epi1_den = EPI(img, img_den1, 1);
str = "SNR = " + num2str(SNR);
disp(str)
str = "using 2nd formulation: EPI = " + num2str(epi1_n) + " (noisy image)";
disp(str)
str = "using 2nd formulation: EPI = " + num2str(epi1_den) + " (denoised image)";
disp(str)

















