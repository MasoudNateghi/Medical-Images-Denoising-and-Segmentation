%% load picture
clear; close all; clc;
img = imread("wall.jpeg");
imshow(img)
%% part a
f = [1, -1];
filtered_img = imfilter(rgb2gray(img), f);
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img)
title('original image', 'Interpreter','latex')

f = [1, 0];
filtered_img = imfilter(img, f);
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img)
title('original image', 'Interpreter','latex')

f = [1, 0, -1]';
filtered_img = imfilter(rgb2gray(img), f);
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img)
title('original image', 'Interpreter','latex')

f = [1, -2, 1];
filtered_img = imfilter(rgb2gray(img), f);
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img)
title('original image', 'Interpreter','latex')

f = [1, -2, 1]';
filtered_img = imfilter(rgb2gray(img), f);
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img)
title('original image', 'Interpreter','latex')
%% part b
filtered_img = edge(rgb2gray(img), "sobel");
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img)
title('original image', 'Interpreter','latex')
sgtitle('sobel', 'interpreter', 'latex')

filtered_img = edge(rgb2gray(img), "canny");
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img)
title('original image', 'Interpreter','latex')
sgtitle('canny', 'interpreter', 'latex')
%% part c
f = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
filtered_img = imfilter(rgb2gray(img), f);
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img)
title('original image', 'Interpreter','latex')
%% part d
img_n = imnoise(img, "gaussian");
f = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
filtered_img = imfilter(rgb2gray(img_n), f);
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img_n)
title('noisy image', 'Interpreter','latex')
sgtitle('laplacian filter', 'interpreter', 'latex')

filtered_img = edge(rgb2gray(img_n), "log");
figure;
subplot(1, 2, 1)
imshow(filtered_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img_n)
title('noisy image', 'Interpreter','latex')
sgtitle('LoG filter', 'interpreter', 'latex')




















