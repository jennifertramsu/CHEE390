function jb = jacob(f, xg, h)
% Calculates the Jacobian for a nonlinear system
% f = vector of functions
% xg = initial guess for each function
% h = small step
% jb = Jacobian matrix

n = length(xg);
jb = zeros(n);

for j = 1:n
    hs = zeros(n, 1);
    hs(j) = h;
    jb(:, j) = d5(f, xg, hs) / (12 * h); % 5-pt Stencil
end

end
