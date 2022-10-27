%% load picture
clear; close all; clc;
img = rgb2gray(imread("histogram.jpeg"));
%% part a
img_en = histeq(img);
figure();
subplot(1, 2, 1);
imshow(img)
title('original image', 'Interpreter','latex');
subplot(1, 2, 2);
imshow(img_en)
title('enhanced image using hisogram equalization', 'Interpreter','latex');
figure();
subplot(1, 2, 1);
imhist(img);
title('histogram of original image', 'Interpreter','latex');
subplot(1, 2, 2);
imhist(img_en);
title('histogram of enhanced image using hisogram equalization', 'Interpreter','latex');
%% part b
figure();
subplot(1, 2, 1);
myimhist(img);
subplot(1, 2, 2);
myimhist(img_en);
sgtitle('histograms using myimhist', 'interpreter', 'latex')
%% part c
img_en_adapt = adapthisteq(img, "NumTiles", [25 25]);
figure();
subplot(1, 2, 1);
imshow(img)
title('original image', 'Interpreter','latex');
subplot(1, 2, 2);
imshow(img_en_adapt)
title('enhanced image using adaptive hisogram equalization', 'Interpreter','latex');
%% part d
figure();
subplot(1, 3, 1);
imhist(img);
title('histogram of original image', 'Interpreter','latex');
subplot(1, 3, 2);
imhist(img_en);
title('histogram of enhanced image using hisogram equalization', 'Interpreter','latex');
subplot(1, 3, 3);
imhist(img_en_adapt);
title('histogram of enhanced image using adaptive hisogram equalization', 'Interpreter','latex');



























