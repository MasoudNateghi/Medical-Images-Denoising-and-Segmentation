function highlight_PV(U)
% Uii = U >= thr;
Uii = zeros(size(U));
for k = 1:size(U, 2)
    Uii(:, k) = double(U(:, k) >= 0.25 & U(:, k) <= 0.8);

end
pmap11 = reshape(Uii(1, :), 200, 256);
pmap21 = reshape(Uii(2, :), 200, 256);
pmap31 = reshape(Uii(3, :), 200, 256);
pmap41 = reshape(Uii(4, :), 200, 256);
multi1 = cat(3, pmap11, pmap21, pmap31, pmap41);
figure;
montage(multi1)