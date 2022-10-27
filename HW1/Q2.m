%% load picture
clear; close all; clc;
img = imread("brainMRI.png");
img = rgb2gray(img);
%% part a
idx1 = floor(size(img, 1) / 2);
idx2 = floor(size(img, 2) / 2);
img_n = zeros(size(img), 'uint8');
temp_salt_pepper = imnoise(img, 'salt & pepper');
temp_gaussian = imnoise(img, "gaussian", 0, 0.05);
n_salt_pepper = temp_salt_pepper - img;
n_gaussian = temp_gaussian - img;
temp_both = img + n_salt_pepper + n_gaussian;
img_n(1:idx1, 1:idx2) = temp_salt_pepper(1:idx1, 1:idx2);
img_n(1:idx1, idx2:end) = img(1:idx1, idx2:end);
img_n(idx1:end, 1:idx2) = temp_gaussian(idx1:end, 1:idx2);
img_n(idx1:end, idx2:end) = temp_both(idx1:end, idx2:end);
imshow(img_n)
%% part b
figure();
imshow(img)
title('original image', 'Interpreter','latex')

% average filter
kernel_size = [3, 5, 7];
for m = kernel_size
    kernel = 1 / m^2 * ones(m);
    filtered_img = imfilter(img_n, kernel, 'replicate');
    figure;
    str = strcat('filtered image using ', num2str(m), '*', num2str(m), ' average filter');
    imshow(filtered_img)
    title(str, 'Interpreter','latex')
end

% median filter
kernel_size = [3, 5, 7];
for m = kernel_size
    filtered_img = medfilt2(img_n, [m m]);
    figure;
    str = strcat('filtered image using ', num2str(m), '*', num2str(m), ' median filter');
    imshow(filtered_img)
    title(str, 'Interpreter','latex')
end

% gaussian filter
sigma = [0.5, 0.8, 1.6];
for m = sigma
    filtered_img = imgaussfilt(img_n, m);
    figure;
    str = strcat('filtered image using gaussian filter with $$\sigma = $$', num2str(m));
    imshow(filtered_img)
    title(str, 'Interpreter','latex')
end
%% part c 
sigma = 0.8; m = 5;
filtered_img1 = imgaussfilt(medfilt2(img_n, [m m]), sigma);
figure;
imshow(filtered_img1)
title('first apply median', 'Interpreter','latex')
filtered_img2 = medfilt2(imgaussfilt(img_n, sigma), [m m]);
figure;
imshow(filtered_img2)
title('first apply gaussian', 'Interpreter','latex')
%% part d
wnr_img = wiener2(img_n, [7, 7]);
subplot(1, 2, 1)
imshow(wnr_img)
title('filtered image', 'Interpreter','latex')
subplot(1, 2, 2)
imshow(img_n)
title('noisy image', 'Interpreter','latex')























