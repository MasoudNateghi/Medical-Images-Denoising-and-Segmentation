function U = modified_initfcm(data, cluster_n)
%INITFCM Generate initial fuzzy partition matrix for fuzzy c-means clustering.
%   U = INITFCM(CLUSTER_N, DATA_N) randomly generates a fuzzy partition
%   matrix U that is CLUSTER_N by DATA_N, where CLUSTER_N is number of
%   clusters and DATA_N is number of data points. The summation of each
%   column of the generated U is equal to unity, as required by fuzzy
%   c-means clustering.
%
%       See also DISTFCM, FCMDEMO, IRISFCM, STEPFCM, FCM.

%   Roger Jang, 12-1-94.
%   Copyright 1994-2002 The MathWorks, Inc. 
data_n = size(data, 1);
U = rand(cluster_n, data_n);
idx = kmeans(data, cluster_n);
for i = 1:cluster_n
    U(i, :) = double(idx == i);
end
