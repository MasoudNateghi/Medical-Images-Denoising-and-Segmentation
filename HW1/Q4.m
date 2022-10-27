%% load picture
clear; close all; clc;
foot = imread("foot.jpg");
hand = imread("hand.jpg");
foot = rgb2gray(foot);
hand = rgb2gray(hand);
figure;
subplot(1, 2, 1)
imshow(foot)
subplot(1, 2, 2)
imshow(hand)
%% part a
F_foot = fft2(foot);
Fsh_foot = fftshift(F_foot);
figure;
imshow(abs(Fsh_foot), [])
title('fourier transform of foot', 'Interpreter','latex')

F_hand = fft2(hand); 
Fsh_hand = fftshift(F_hand);
figure;
imshow(abs(Fsh_hand), [])
title('fourier transform of hand', 'Interpreter','latex')
%% part b
k = 255 / max(log(abs(Fsh_foot(:)) + 1));
figure;
imshow(k*log(abs(Fsh_foot) + 1), [])
title('fourier transform of foot', 'Interpreter','latex')

k = 255 / max(log(abs(Fsh_hand(:)) + 1));
figure;
imshow(k*log(abs(Fsh_hand) + 1), [])
title('fourier transform of hand', 'Interpreter','latex')
%% part c
phase_foot = angle(F_foot);
amp_foot = abs(F_foot);

phase_hand = angle(F_hand);
amp_hand = abs(F_hand);

% foot phase and hand amplitude
F_new1 = amp_hand .* exp(1i*phase_foot);
img1 = ifft2(F_new1);
figure;
imshow(uint8(img1))
title('foot phase and hand amplitude', 'Interpreter','latex')

% foot amplitude and hand phase
F_new2 = amp_foot .* exp(1i*phase_hand);
img2 = ifft2(F_new2);
figure;
imshow(uint8(img2))
title('foot amplitude and hand phase', 'Interpreter','latex')











































