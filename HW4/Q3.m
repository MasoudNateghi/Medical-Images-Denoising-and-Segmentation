%% part 1.3
clear; close all; clc;
nev = imread("nevus_gray.jpg");
mel = imread("melanoma_gray.jpg");
% mode 1: select the center of a 9*9 square window inside the region
% mode 2: draw boundary of the region
chan_vese(nev, 1);
chan_vese(mel, 1);
chan_vese(nev, 2);
chan_vese(mel, 2);
%% part 2.3
img = imread("MRI3.jpg");
chan_vese(img, 1);
chan_vese(img, 2);
%% automate
thresh = multithresh(img, 4);
mask = img >= thresh(4);
BW = activecontour(img, mask);
hit = uint8(BW .* double(img));
miss = uint8(~BW .* double(img));
BW_montage = double(BW);
BW_montage(BW_montage == 1) = 255;
multi = cat(3, img, uint8(BW_montage), hit, miss);
figure;
montage(multi)
title("Original (Top Left), Binary Mask (Top Right), Hit (Bottom Left)" + ...
    ", Miss (Bottom Right)", "Interpreter","latex")