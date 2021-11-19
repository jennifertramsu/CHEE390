function [fk] = fugacity(x, ak, bk, Z, A, B, k, P)

Xa = (x.*ak) * ones(length(x), 1);
b = (x.*bk) * ones(length(bk), 1);
a = 0;

for i = 1:length(k)
    for j = 1:length(k(:, i))
        aij = (1 - k(i, j))*sqrt(ak(i)*ak(j));
        a = a + x(i)*x(j)*aij;
    end
end

ln = (bk./b).*(Z - 1) - log(Z - B) - A ./ (2*sqrt(2).*B) * (2*Xa./a - bk./b) .* log((Z + 2.414*B) ./ (Z - 0.414.*B));
fk = x.*P .* log(ln);

end