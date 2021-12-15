function P = vapfrac(v, z, K)
% Residual function to determine vapour fraction
% v = vapour fraction
% z = total composition fractions
% K = K-factors
% P = residual function

P = 0;

for i = 1:length(z)
    P = P + (z(i)*(K(i) - 1)) / (1 + v*(K(i) - 1));
end

end