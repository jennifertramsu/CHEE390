function [g] = gammas(x, T, Tc)

g = zeros(1, 2);

xa = [x(1), 1 - x(1)];
xb = [1 - x(2), x(2)];

xs = [xa', xb'];

for i = 1:2
    frac = xs(:, i);
    x1 = frac(1);
    x2 = frac(2);

    k = (x1 * (1 + x2)) / (x2 * (1 + x1));
    a = (Tc * (x1 + x2*k)^3) / (2*x1*x2*k^2);
    b = a*k;

    A = a./T;
    B = b./T;
    
    if i == 1
        g(1) = exp(A / (1 + (A*x1) / (B*x2))^2);
    else
        g(2) = exp(B / (1 + (B*x2) / (A*x1))^2);
    end
end

end