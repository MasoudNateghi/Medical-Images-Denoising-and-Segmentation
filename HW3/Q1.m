%% load image
clear; close all; clc;
img = imread("hand.jpg");
%% part a
img_n = imnoise(img, "gaussian", 0.05, 0.01);
img = rgb2gray(img);
img_n = rgb2gray(img_n);
img = double(img);
img_n = double(img_n);
multi = cat(3, img, img_n);
montage(uint8(multi))
title("original image (left), noisy image (right)", "Interpreter","latex")
%% part b
% we apply a gaussian kernel with size 5*5
l = 5;
img_embed = zeros(size(img)+(l-1));
img_embed((l+1)/2:end-(l-1)/2, (l+1)/2:end-(l-1)/2) = img_n;
Gx = zeros(l);
hx = 0.5;
for i = 1:l
    for j = 1:l
        Gx(i, j) = exp(-((i-(l+1)/2)^2 + (j-(l+1)/2)^2) / (2*hx^2));
    end
end
img_den1 = zeros(size(img));
for i = 1:651
    for j = 1:719
        img_den1(i, j) = sum(img_embed(i:i+(l-1), j:j+(l-1)) .* Gx, "all") / sum(Gx, "all");
    end
end
multi = cat(3, img_n, img_den1);
montage(uint8(multi))
title("Classical Regression Filtering: noisy image (left), denoised image (right)", "Interpreter","latex")
%% part c
Gx = zeros(l);
hx = 1;
for i = 1:l
    for j = 1:l
        Gx(i, j) = exp(-((i-(l+1)/2)^2 + (j-(l+1)/2)^2) / (2*hx^2));
    end
end
% hx = 0.02 * sqrt(size(img, 1)^2 + size(img, 2)^2);
[~,~,~,cD] = dwt2(img_n, "haar");
sigma_N = median(abs(cD(:))) / 0.6745;
% hg = 1.95 * sigma_N;
hg = 100;
img_den2 = zeros(size(img));
for i = 1:651
    for j = 1:719
        Gg = exp(-(img_embed(i:i+(l-1), j:j+(l-1)) - img_embed(i+(l-1)/2, j+(l-1)/2))^2 / (2*hg^2));
        G = Gg .* Gx;
        img_den2(i, j) = sum(img_embed(i:i+(l-1), j:j+(l-1)) .* G, "all") / sum(G, "all");
    end
end
figure;
multi = cat(3, img_n, img_den2);
montage(uint8(multi))
title("Bilateral Filtering: noisy image (left), denoised image (right)", "Interpreter","latex")
%% part d
% !!!!!!!!!!!!!!!  LONG RUNTIME  !!!!!!!!!!!!!!!
% when c = 468000, simulation finishes
L = 9; % search window size
l = 3;  % similarity window size
hv = 50;
c= 1;
Gp = 1;

img_den3 = zeros(size(img));
img_embed = zeros(size(img)+l-1);
img_embed((l+1)/2:end-(l-1)/2, (l+1)/2:end-(l-1)/2) = img_n;

for i = 1:651
    for j = 1:719
        c = c + 1;
        if rem(c, 1000) == 0
            c %#ok<NOPTS> 
        end
        Sx = img_embed(i:i+l-1, j:j+l-1); % fixed similarity window
        if i + (l-1)/2 - (L-1)/2 <= 0; start_idx_i = 1; else; start_idx_i = i + (l-1)/2 - (L-1)/2; end 
        if j + (l-1)/2 - (L-1)/2 <= 0; start_idx_j = 1; else; start_idx_j = j + (l-1)/2 - (L-1)/2; end
        if i + (l-1)/2 + (L-1)/2 >= 651 + (l-1); end_idx_i = 651 + (l-1)/2; else; end_idx_i = i + (l-1)/2 + (L-1)/2; end
        if j + (l-1)/2 + (L-1)/2 >= 719 + (l-1); end_idx_j = 719 + (l-1)/2; else; end_idx_j = j + (l-1)/2 + (L-1)/2; end
        search_window = img_embed(start_idx_i:end_idx_i, start_idx_j:end_idx_j);
        G = zeros(size(search_window));
        for m = 1:size(search_window, 1)-(l-1)
            for n = 1:size(search_window, 2)-(l-1)
                Sy = search_window(m:m+l-1, n:n+l-1); % floating similarity window
                G(m, n) = exp(-Gp*sum((Sx-Sy).^2, "all") / (2*hv^2));
            end
        end
        img_den3(i, j) = sum(search_window .* G, "all") / sum(G, "all");

    end
end
multi = cat(3, img_n, img_den3, img);
montage(uint8(multi), 'Size', [1 3])
title("NLM Filtering: noisy image (left), denoised image (middle), original image (right)", "Interpreter","latex")
%% part f
SNR1 = 10 * log10(sum(img .^ 2, "all") / sum((img - img_den1) .^2, "all"));
SNR2 = 10 * log10(sum(img .^ 2, "all") / sum((img - img_den2) .^2, "all"));
SNR3 = 10 * log10(sum(img .^ 2, "all") / sum((img - img_den3) .^2, "all"));
str1 = "part a: SNR = " + num2str(SNR1);
str2 = "part b: SNR = " + num2str(SNR2);
str3 = "part c: SNR = " + num2str(SNR3);
disp(str1)
disp(str2)
disp(str3)
multi = cat(3, img_den1, img_den2, img_den3, img);
montage(uint8(multi), 'Size', [2 2])







