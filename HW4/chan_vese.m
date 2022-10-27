function chan_vese(img, mode)
figure;
imshow(img)
if mode == 1
    disp("Select a point inside the region: ")
    [x,y] = ginput(1);
    close
    c = [x-4, x+4, x+4, x-4];
    r = [y+4, y+4, y-4, y-4];
    mask = roipoly(img,c,r);
elseif mode == 2
    disp("Select boundary of the region: ")
    mask = roipoly;
    close
end
BW = activecontour(img, mask);
hit = uint8(BW .* double(img));
miss = uint8(~BW .* double(img));
BW_montage = double(BW);
BW_montage(BW_montage == 1) = 255;
multi = cat(3, img, uint8(BW_montage), hit, miss);
figure;
montage(multi)
title("Original (Top Left), Binary Mask (Top Right), Hit (Bottom Left)" + ...
    ", Miss (Bottom Right)", "Interpreter","latex")