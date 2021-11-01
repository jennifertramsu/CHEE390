function [g] = gammas(xs, A, B)
% xs = array of compositions for species 1 [amount in alpha phase, amount in
% beta phase]
% A = 
% B = 

g = zeros(2); % first row for alpha, second row for beta

for i = 1:2 % for each phase
    x1 = xs(i);
    x2 = 1 - x1;
    
    g(i, 1) = exp(A / (1 + ((A*x1) / (B*x2)))^2); % g1
    g(i, 2) = exp(B / (1 + ((B*x2) / (A*x1)))^2); % g2

end

end