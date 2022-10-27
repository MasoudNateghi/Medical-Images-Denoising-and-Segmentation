%% load picture
clear; close all; clc;
img1 = imread("river\river1.png");
img2 = imread("river\river2.png");
img3 = imread("river\river3.png");
img4 = imread("river\river4.png");
img5 = imread("river\river5.png");
img6 = imread("river\river6.png");

img1 = double(rgb2gray(img1));
img2 = double(rgb2gray(img2));
img3 = double(rgb2gray(img3));
img4 = double(rgb2gray(img4));
img5 = double(rgb2gray(img5));
img6 = double(rgb2gray(img6));
%%
imgpca(img1, 20)
imgpca(img1, 100)
imgpca(img2, 100)
imgpca(img3, 100)
imgpca(img4, 100)
imgpca(img5, 100)
imgpca(img6, 100)



























