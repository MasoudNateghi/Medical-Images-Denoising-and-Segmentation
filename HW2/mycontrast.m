function C = mycontrast(p)
K = length(p);
C = 0;
for i = 1:K
    for j = 1:K
        C = C + ((i - j) ^ 2) * p(i, j);
    end
end