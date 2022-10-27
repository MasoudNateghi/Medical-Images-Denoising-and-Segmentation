%% load images
clear; close all; clc;
img1 = imread("brain.jpg");
img2 = imread("sample.png");
figure;
imshow(img1)
figure;
imshow(img2)
%% part a
figure;
histogram(img1(:), "NumBins", 256, "Normalization","probability")
[counts,binLocations] = imhist(img1);
N = numel(img1);
p = counts / N;
mu = sum(binLocations.*p); % mean
sigma = sum(((binLocations - mu).^2) .* p); % variance
U = sum(p.^2); % uniformity
E = -sum(p(p~=0) .* log2(p(p~=0))); % entropy
disp("brain.jpg features")
disp("mean = " + num2str(mu));
disp("variance = " + num2str(sigma));
disp("uniformity = " + num2str(U));
disp("entropy = " + num2str(E));
%% part b
figure;
histogram(img2(:), "NumBins", 256, "Normalization","probability")
[counts,binLocations] = imhist(img2);
N = numel(img2);
p = counts / N;
mu = sum(binLocations.*p); % mean
sigma = sum(((binLocations - mu).^2) .* p); % variance
U = sum(p.^2); % uniformity
E = -sum(p(p~=0) .* log2(p(p~=0))); % entropy
disp("sample.png features")
disp("mean = " + num2str(mu));
disp("variance = " + num2str(sigma));
disp("uniformity = " + num2str(U));
disp("entropy = " + num2str(E));
%% part c
glcms1 = graycomatrix(img1, "NumLevels", 256);
glcms2 = graycomatrix(img2, "NumLevels", 256);
%% part d
p1 = glcms1 / sum(glcms1, "all");
p2 = glcms2 / sum(glcms2, "all");
% contrast
C1 = mycontrast(p1);
C2 = mycontrast(p2);
% Uniformity
U1 = sum(p1.^2, "all");
U2 = sum(p2.^2, "all");
% Homogenity
H1 = myhomogenity(p1);
H2 = myhomogenity(p2);
% Entropy
E1 = -sum(p1(p1~=0).*log2(p1(p1~=0)), "all");
E2 = -sum(p2(p2~=0).*log2(p2(p2~=0)), "all");
disp("brain.jpg features")
disp("Contrast = " + num2str(C1));
disp("uniformity = " + num2str(U1));
disp("Homogenity = " + num2str(H1));
disp("Entropy = " + num2str(E1));
disp("sample.png features")
disp("Contrast = " + num2str(C2));
disp("uniformity = " + num2str(U2));
disp("Homogenity = " + num2str(H2));
disp("Entropy = " + num2str(E2));
%% part e
% quantize features
thresh = 0:4:252-4;
values = [thresh, max(img1(:))];
quant1 = imquantize(img1, thresh);
quant2 = imquantize(img2, thresh);
img1Quant = values(quant1);
img2Quant = values(quant2);
figure;
imshow(img1Quant)
figure;
imshow(img2Quant)
% extract features
glcms1 = graycomatrix(img1Quant, "NumLevels", 64);
glcms2 = graycomatrix(img2Quant, "NumLevels", 64);
p1 = glcms1 / sum(glcms1, "all");
p2 = glcms2 / sum(glcms2, "all");
% contrast
C1 = mycontrast(p1);
C2 = mycontrast(p2);
% Uniformity
U1 = sum(p1.^2, "all");
U2 = sum(p2.^2, "all");
% Homogenity
H1 = myhomogenity(p1);
H2 = myhomogenity(p2);
% Entropy
E1 = -sum(p1(p1~=0).*log2(p1(p1~=0)), "all");
E2 = -sum(p2(p2~=0).*log2(p2(p2~=0)), "all");
disp("brain.jpg (Quantized) features")
disp("Contrast = " + num2str(C1));
disp("uniformity = " + num2str(U1));
disp("Homogenity = " + num2str(H1));
disp("Entropy = " + num2str(E1));
disp("sample.png (Quantized) features")
disp("Contrast = " + num2str(C2));
disp("uniformity = " + num2str(U2));
disp("Homogenity = " + num2str(H2));
disp("Entropy = " + num2str(E2));













