function H = myhomogenity(p)
K = length(p);
H = 0;
for i = 1:K
    for j = 1:K
        H = H + p(i, j) / (1 + abs(i-j));
    end
end