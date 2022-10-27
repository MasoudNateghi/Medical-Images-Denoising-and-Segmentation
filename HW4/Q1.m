%% part 1.1
clear; close all; clc; 
img1 = imread("MRI1.jpg"); 
img2 = imread("MRI2.png"); 
img3 = imread("MRI3.png"); 
img4 = imread("MRI4.png");
img1 = double(img1);
img2 = double(img2);
img3 = double(img3);
img4 = double(img4);
figure;
RGB1 = cat(3, img1, img3, img4);
RGB2 = cat(3, img1, img4, img2);
montage({uint8(RGB1), uint8(RGB2)})
%% part 2.1
data = [img1(:), img2(:), img3(:), img4(:)];
for c = [2 5 1.1]
    disp("clustering coefficient = " + num2str(c))
    options = [c NaN NaN 1];
    [~,U1] = fcm(data, 4, options);
    pmap11 = reshape(U1(1, :), 200, 256);
    pmap21 = reshape(U1(2, :), 200, 256);
    pmap31 = reshape(U1(3, :), 200, 256);
    pmap41 = reshape(U1(4, :), 200, 256);
    multi1 = cat(3, pmap11, pmap21, pmap31, pmap41);
    figure;
    montage(multi1)
    title("clustering coefficient = " + num2str(c), "Interpreter","latex")
end
%% part 3.1
for k = 2:5
    idx = kmeans(data, k, 'Display', 'final');
    pmap = zeros(200, 256, k);
    for m = 1:k
        pmap(:, :, m) = reshape(double(idx == m), 200, 256);
    end
    figure;
    montage(pmap, "Size", [1, m])
end

for c = [2 5 1.1]
    disp("clustering coefficient = " + num2str(c))
    options = [c NaN NaN 1];
    [~,U2] = modified_fcm(data, 4, options);
    pmap12 = reshape(U2(1, :), 200, 256);
    pmap22 = reshape(U2(2, :), 200, 256);
    pmap32 = reshape(U2(3, :), 200, 256);
    pmap42 = reshape(U2(4, :), 200, 256);
    multi2 = cat(3, pmap12, pmap22, pmap32, pmap42);
    figure;
    montage(multi2)
    title("clustering coefficient = " + num2str(c), "Interpreter","latex")
end
%% part 4.1
k = 4;
options = [2 NaN NaN 0];
[~, U] = fcm(data, k, options);
[~, cluster] = max(U);
cluster_data1 = data(cluster == 1, :);
cluster_data2 = data(cluster == 2, :);
cluster_data3 = data(cluster == 3, :);
cluster_data4 = data(cluster == 4, :);
mu1 = mean(cluster_data1);
mu2 = mean(cluster_data2);
mu3 = mean(cluster_data3);
mu4 = mean(cluster_data4);

cov1 = cov(cluster_data1);
cov2 = cov(cluster_data2);
cov3 = cov(cluster_data3);
cov4 = cov(cluster_data4);

gm1 = gmdistribution(mu1,cov1);
gm2 = gmdistribution(mu2,cov2);
gm3 = gmdistribution(mu3,cov3);
gm4 = gmdistribution(mu4,cov4);

map = zeros(200, 256, 4);

count = 1;
for n = 1:256
    for m = 1:200
        map(m, n, 1) = pdf(gm1, data(count, :));
        map(m, n, 2) = pdf(gm2, data(count, :));
        map(m, n, 3) = pdf(gm3, data(count, :));
        map(m, n, 4) = pdf(gm4, data(count, :));
        count = count + 1;
    end
end

P = zeros(200, 256);
for i = 1:4; P = P + map(:, :, i); end
map = map ./ P;
montage(map)
%% part 5.1
options = [5 NaN NaN 0];
[~,U] = modified_fcm(data, 4, options);
PVE = zeros(200, 256);
count = 1;
for n = 1:256
    for m = 1:200
        sorted_probs = sort(U(:, count), "descend");
        if sorted_probs(1) / sorted_probs(2) < 1.1; PVE(m, n) = 1; end
        count = count + 1;
    end
end
montage(PVE)
