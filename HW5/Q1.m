clear; close all; clc;
cd BCFCM\
Y = im2double(imread("test_biasfield_noise.png"));
options = struct('alpha', 2, 'maxit', 20, 'epsilon', 1e-5);
v = [0.42;0.56;0.64];
[B,U]=BCFCM2D(Y, v, options);
figure, 
subplot(2,2,1), imshow(Y), title('input image', "Interpreter","latex");
subplot(2,2,2), imshow(U), title('Partition matrix', "Interpreter","latex");
subplot(2,2,3), imshow(B,[]), title('Estimated biasfield', "Interpreter","latex");
subplot(2,2,4), imshow(Y-B), title('Corrected image', "Interpreter","latex");
cd ..