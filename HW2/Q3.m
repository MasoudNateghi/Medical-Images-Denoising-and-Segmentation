%% load images
clear; close all; clc;
img = imread("boat.png");
figure;
imshow(img)
%% part b
LoD = [(1+sqrt(3)), (3+sqrt(3)), (3-sqrt(3)), (1-sqrt(3))] / (4*sqrt(2));
HiD = [(1-sqrt(3)), (-3+sqrt(3)), (3+sqrt(3)), (-1-sqrt(3))] / (4*sqrt(2));
[cA,cH,cV,cD] = dwt2(img,LoD,HiD);
figure;
subplot(2,2,1)
imagesc(cA)
colormap gray
title('Approximation', "Interpreter","latex", "FontSize", 20)
subplot(2,2,2)
imagesc(cH)
colormap gray
title('Horizontal', "Interpreter","latex", "FontSize", 20)
subplot(2,2,3)
imagesc(cV)
colormap gray
title('Vertical', "Interpreter","latex", "FontSize", 20)
subplot(2,2,4)
imagesc(cD)
colormap gray
title('Diagonal', "Interpreter","latex", "FontSize", 20)
%% part c
LoR = [(3-sqrt(3)), (3+sqrt(3)), (1+sqrt(3)), (1-sqrt(3))] / (4*sqrt(2));
HiR = [(1-sqrt(3)), (-1-sqrt(3)), (3+sqrt(3)), (-3+sqrt(3))] / (4*sqrt(2));
imgR = idwt2(cA,cH,cV,cD,LoR,HiR);
figure;
subplot(121)
imshow(uint8(imgR))
title("reconstructed image", "Interpreter","latex", "FontSize", 20)
subplot(122)
imshow(img)
title("original image", "Interpreter","latex", "FontSize", 20)
rmse = sqrt(mean((double(img) - double(imgR)).^2, "all"));
disp("reconstruction error = " + num2str(rmse))
%% part d
[C, S] = wavedec2(img, 1, LoD, HiD);
C_sorted = sort(C, "descend");
% 95%
p = 0.95;
n = floor(length(C)*p);
thr = C_sorted(n);
C_new = (C >= thr) .* C;
imgR95 = waverec2(C_new, S, LoR, HiR);
% 40%
p = 0.40;
n = floor(length(C)*p);
thr = C_sorted(n);
C_new = (C >= thr) .* C;
imgR40 = waverec2(C_new, S, LoR, HiR);
% 5%
p = 0.05;
n = floor(length(C)*p);
thr = C_sorted(n);
C_new = (C >= thr) .* C;
imgR5 = waverec2(C_new, S, LoR, HiR);
% plot
figure;
subplot(221)
imshow(img)
title("original image", "Interpreter","latex", "FontSize", 20)
subplot(222)
imshow(uint8(imgR95))
title("reconstructed image (95\%)", "Interpreter","latex", "FontSize", 20)
subplot(223)
imshow(uint8(imgR40))
title("reconstructed image (40\%)", "Interpreter","latex", "FontSize", 20)
subplot(224)
imshow(uint8(imgR5))
title("reconstructed image (5\%)", "Interpreter","latex", "FontSize", 20)
sgtitle("Wavelet Transform for Image Compression", "interpreter", "latex", "FontSize", 20)
% rmse
rmse = sqrt(mean((double(img) - double(imgR95)).^2, "all"));
disp("reconstruction error (95%) = " + num2str(rmse))
rmse = sqrt(mean((double(img) - double(imgR40)).^2, "all"));
disp("reconstruction error (40%) = " + num2str(rmse))
rmse = sqrt(mean((double(img) - double(imgR5)).^2, "all"));
disp("reconstruction error (5%) = " + num2str(rmse))
%% part e
% save images
imwrite(uint8(imgR95), "boat95.png")
imwrite(uint8(imgR40), "boat40.png")
imwrite(uint8(imgR5), "boat5.png")
% find size of images on disk
s = dir("boat.png");
filesize = s.bytes;
s = dir("boat5.png");
filesize5 = s.bytes;
s = dir("boat40.png");
filesize40 = s.bytes;
s = dir("boat95.png");
filesize95 = s.bytes;
% calculate compression ratio
CR5 = filesize / filesize5;
CR40 = filesize / filesize40;
CR95 = filesize / filesize95;
disp("using wavelet transform")
disp("Compression Ratio (95%) = " + num2str(CR95) + ":1")
disp("Compression Ratio (40%) = " + num2str(CR40) + ":1")
disp("Compression Ratio (5%) = " + num2str(CR5) + ":1")
%% fft2
I = fft2(img);
Ivec = reshape(I, 1, numel(I));
Iabs = abs(Ivec);
I_sorted = sort(Iabs, "descend");
% 95%
p = 0.95;
n = floor(length(Ivec)*p);
thr = I_sorted(n);
Ivec_new = (Iabs >= thr) .* Ivec;
IR95 = reshape(Ivec_new, size(I));
imgFR95 = ifft2(IR95);
% 40%
p = 0.40;
n = floor(length(Ivec)*p);
thr = I_sorted(n);
Ivec_new = (Iabs >= thr) .* Ivec;
IR40 = reshape(Ivec_new, size(I));
imgFR40 = ifft2(IR40);
% 5%
p = 0.05;
n = floor(length(Ivec)*p);
thr = I_sorted(n);
Ivec_new = (Iabs >= thr) .* Ivec;
IR5 = reshape(Ivec_new, size(I));
imgFR5 = ifft2(IR5);
% plot
figure;
subplot(221)
imshow(img)
title("original image", "Interpreter","latex", "FontSize", 20)
subplot(222)
imshow(uint8(imgFR95))
title("reconstructed image (95\%)", "Interpreter","latex", "FontSize", 20)
subplot(223)
imshow(uint8(imgFR40))
title("reconstructed image (40\%)", "Interpreter","latex", "FontSize", 20)
subplot(224)
imshow(uint8(imgFR5))
title("reconstructed image (5\%)", "Interpreter","latex", "FontSize", 20)
sgtitle("Fourier Transform for Image Compression", "interpreter", "latex", "FontSize", 20)
% save images
imwrite(uint8(imgFR95), "boatF95.png")
imwrite(uint8(imgFR40), "boatF40.png")
imwrite(uint8(imgFR5), "boatF5.png")
% find size of images on disk
s = dir("boat.png");
filesize = s.bytes;
s = dir("boatF5.png");
filesize5 = s.bytes;
s = dir("boatF40.png");
filesize40 = s.bytes;
s = dir("boatF95.png");
filesize95 = s.bytes;
% calculate compression ratio
CR5 = filesize / filesize5;
CR40 = filesize / filesize40;
CR95 = filesize / filesize95;
disp("using fourier transform")
disp("Compression Ratio (95%) = " + num2str(CR95) + ":1")
disp("Compression Ratio (40%) = " + num2str(CR40) + ":1")
disp("Compression Ratio (5%) = " + num2str(CR5) + ":1")





















