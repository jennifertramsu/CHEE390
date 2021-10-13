function jb = jacob(f, xg, h)
% f = vector of functions
% xg = initial guess for each function
% h = small step

n = length(xg);
jb = zeros(n, n);

for j = 1:n
    hs = zeros(n, 1);
    hs(j) = h;
    jb(:, j) = d3(f, xg, hs) / (2 * h);
end

end
