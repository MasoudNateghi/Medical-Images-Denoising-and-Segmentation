function myimhist(img)
n = zeros(1, 256);
for i = 1:numel(img)
    n(img(i)+1) = n(img(i)+1) + 1;
end
bar(n)
colorbar("southoutside")
caxis([0 255])
colormap("gray")





























