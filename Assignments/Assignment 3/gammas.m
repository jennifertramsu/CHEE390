function [g] = gammas(x, T, Tc)
% x = array of compositions for species 1 [amount in alpha phase, amount in
% beta phase]
% T = current temperature
% Tc = critical temperature

g = zeros(2, 2); % first row for alpha, second row for beta

xa = [x(1), 1 - x(1)]; % [x1, x2] in alpha phase
xb = [x(2), 1 - x(2)]; %  [x1, x2] in beta phase

xs = [xa; xb];

for i = 1:2 % for each phase
    phase = xs(i, :);
    x1 = phase(1);
    x2 = phase(2);

    k = (x1 * (1 + x2)) / (x2 * (1 + x1));
    a = (Tc * (x1 + x2*k)^3) / (2*x1*x2*k^2);
    b = a*k;

    A = a./T;
    B = b./T;
    
    g(i, 1) = exp(A / (1 + (A*x1) / (B*x2))^2); % g1
    g(i, 2) = exp(B / (1 + (B*x2) / (A*x1))^2); % g2

end

end