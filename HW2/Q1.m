clear; close all; clc;
img1 = imread("melanome1.jpg");
img2 = imread("melanome2.jpg");
img3 = imread("melanome3.jpg");
img4 = imread("melanome4.JPG");
%% binarize
img1Bin = ~im2bw(img1, 0.25); %#ok<IM2BW> 
img2Bin = ~im2bw(img2, 0.25); %#ok<IM2BW> 
img3Bin = ~im2bw(img3, 0.25); %#ok<IM2BW> 
img4Bin = ~im2bw(img4, 0.25); %#ok<IM2BW> 

figure;
subplot(2,2,1)
imshow(img1Bin)
title("melanome 1", "Interpreter","latex")
subplot(2,2,2)
imshow(img2Bin)
title("melanome 2", "Interpreter","latex")
subplot(2,2,3)
imshow(img3Bin)
title("melanome 3", "Interpreter","latex")
subplot(2,2,4)
imshow(img4Bin)
title("melanome 4", "Interpreter","latex")
figure;
subplot(2,2,1)
imshow(img1)
title("melanome 1", "Interpreter","latex")
subplot(2,2,2)
imshow(img2)
title("melanome 2", "Interpreter","latex")
subplot(2,2,3)
imshow(img3)
title("melanome 3", "Interpreter","latex")
subplot(2,2,4)
imshow(img4)
title("melanome 4", "Interpreter","latex")
%% part a
se1 = strel("square", 7);
se2 = strel("square", 3);
img1Enh = imdilate(img1Bin, se1);
img1Enh = imerode(img1Enh, se2);

figure;
subplot(2, 2, 1)
imshow(img1Enh)
title("final mask", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 2)
imshow(uint8(img1Enh).*img1)
title("hit", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 3)
imshow(uint8(~img1Enh).*img1)
title("miss", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 4)
imshow(img1)
title("original image", "Interpreter","latex", "FontSize", 20)
%% part b
se1 = strel("square", 3);
img2Enh = imerode(img2Bin, se1);
img2Enh = imdilate(img2Enh, se1);

figure;
subplot(2, 2, 1)
imshow(img2Enh)
title("final mask", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 2)
imshow(uint8(img2Enh).*img2)
title("hit", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 3)
imshow(uint8(~img2Enh).*img2)
title("miss", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 4)
imshow(img2)
title("original image", "Interpreter","latex", "FontSize", 20)
%% part c
se1 = strel("square", 5);
se2 = strel("square", 3);
img3Enh = imdilate(img3Bin, se1);
img3Enh = imclose(img3Enh, se1);
img3Enh = imfill(img3Enh, "holes");
img3Enh = imerode(img3Enh, se2);

figure;
subplot(2, 2, 1)
imshow(img3Enh)
title("final mask", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 2)
imshow(uint8(img3Enh).*img3)
title("hit", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 3)
imshow(uint8(~img3Enh).*img3)
title("miss", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 4)
imshow(img3)
title("original image", "Interpreter","latex", "FontSize", 20)
%% part d
img4Enh = imopen(img4Bin, strel("square", 17));
img4Enh = imerode(img4Enh, strel("square", 10));
img4Enh = imdilate(img4Enh, strel("square", 7));
img4Enh = imopen(img4Enh, strel("square", 20));

figure;
subplot(2, 2, 1)
imshow(img4Enh)
title("final mask", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 2)
imshow(uint8(img4Enh).*img4)
title("hit", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 3)
imshow(uint8(~img4Enh).*img4)
title("miss", "Interpreter","latex", "FontSize", 20)
subplot(2, 2, 4)
imshow(img4)
title("original image", "Interpreter","latex", "FontSize", 20)
%% part e
[L, n] = bwlabeln(img4Enh);
figure;
subplot(1, 2, 1)
imshow(L == 1)
title("first component", "Interpreter","latex")
subplot(1, 2, 2)
imshow(L == 2)
title("second component", "Interpreter","latex")
str = "number of components = " + num2str(n);
disp(str)


















