function da = dp(v, z, K)
% Calculates the derivative of the residual function for vapour fraction
% v = vapour fraction
% z = total composition fractions
% K = K-factors
% da = derivative of residual function

da = 0;

for i = 1:length(z)
    da = da + z(i)*(K(i) - 1)^2 / (1 + v*(K(i) - 1))^2;
end

da = -da;

end