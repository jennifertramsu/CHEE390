function [x] = thomas(a, b, c, d)
% Thomas Algorithm to solve tridiagonal matrices
% Phillip Servio (c) 2010
% a, b, c, d = coefficient vectors
% x = solution

% Initializing
n = length(a);
x = zeros(1, n);
p = x;
q = x;

% Forward substitution
p(1) = -c(1) / b(1);
q(1) = d(1) / b(1);

for i = 2:n
    bd = a(i) * p(i - 1) + b(i);
    p(i) = -c(i) / bd;
    q(i) = (d(i) - a(i) * q(i - 1)) / bd;
end

% Back Substitution

x(n) = q(n);

for i = n-1:-1:1
    x(i) = p(i) * x(i + 1) + q(i);
end

end