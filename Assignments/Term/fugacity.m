function [fk] = fugacity(c, a, b, ak, bk, Z, A, B, P, kap)
% Calculates the fugacity of all species
% c = composition
% a, b = mixture mixing coefficients
% ak, bk = pure mixing coefficients
% Z = compressibility factor
% A, B = constants in PR EOS
% P = pressure
% kap = interaction parameters
% fk = fugacity

Xa = zeros(1, length(c));

for k = 1:length(c)
    for i = 1:length(c)
        Xa(k) = Xa(k) + (c(i)*(1 - kap(i, k)) * sqrt(ak(i) * ak(k)));
    end
end

ln = (bk./b).*(Z - 1) - log(Z - B) - (A / (2*sqrt(2)*B)) .* ((2*Xa)/a - bk./b) * log((Z + 2.414.*B) ./ (Z - 0.414.*B));
fk = c.*P .* exp(ln);

end