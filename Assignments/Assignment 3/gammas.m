function [g] = gammas(x, T, Tc)

g = zeros(1, 2);

x1 = x(1);
x2 = x(2);

k = (x1 * (1 + x2)) / (x2 * (1 + x1));
a = (Tc * (x1 + x2*k)^3) / (2*x1*x2*k^2);
b = a*k;

A = a./T;
B = b./T;

g(1) = exp(A / (1 + (A*x1) / (B*x2))^2);
g(2) = exp(B / (1 + (B*x2) / (A*x1))^2);

end