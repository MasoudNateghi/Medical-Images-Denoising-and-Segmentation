function epi = EPI(ROI, ROI_n, option)
% using images: option 0
% using laplacians: option 1
if option == 0
    s = mean(ROI, "all");
    s_hat = mean(ROI_n, "all");
    num = sum((ROI - s) .* (ROI_n - s_hat), "all");
    denum = sqrt(sum((ROI - s) .^ 2, "all") * sum((ROI_n - s_hat) .^ 2, "all"));
    epi = num / denum;
elseif option == 1
    f = [-1 -1 -1; -1 8 -1; -1 -1 -1];
    dROI = imfilter(ROI, f);
    dROI_n = imfilter(ROI_n, f);
    ds = mean(dROI, "all");
    ds_hat = mean(dROI_n, "all");
    num = sum((dROI - ds) .* (dROI_n - ds_hat), "all");
    denum = sqrt(sum((dROI - ds) .^ 2, "all") * sum((dROI_n - ds_hat) .^ 2, "all"));
    epi = num / denum;
else
    disp("Wrong Option!")
end












