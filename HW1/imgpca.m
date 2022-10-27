function imgpca(img1, d)
% d: number of principal components for reconstructing image

[coeff, score, latent] = pca((img1-mean(img1, 2))');
B = diag(latent)^(-1/2) * coeff';
z = diag(latent)^(-1/2) * score';
figure;
subplot(1, 3, 1)
imshow(uint8(score))
title('white image', 'Interpreter','latex')

reconstructed_img = pinv(B(1:d, :)) * z(1:d, :) + mean(img1, 2);
subplot(1, 3, 2)
imshow(uint8(img1))
title('original image', 'Interpreter','latex')
subplot(1, 3, 3)
imshow(uint8(reconstructed_img))
str = strcat('compressed image using', num2str(d), ' components');
title(str, 'Interpreter','latex')