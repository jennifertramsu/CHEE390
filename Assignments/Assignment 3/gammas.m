function [g] = gammas(xs, A, B)
% Calculates the activities based on the van Laar coefficient model
% xs = array of compositions for species 1 [amount in alpha phase, amount in
% beta phase]
% A = constant (a/T)
% B = constant (b/T)
% g = 2x2 array of activity coefficients, one for each species in each phase

g = zeros(2); % first row for alpha, second row for beta

for i = 1:2 % for each phase
    x1 = xs(i); % Mole fraction of species 1
    x2 = 1 - x1; % Because mole fractions add to unity
    
    g(i, 1) = exp(A / (1 + ((A*x1) / (B*x2)))^2); % g1
    g(i, 2) = exp(B / (1 + ((B*x2) / (A*x1)))^2); % g2

end

end