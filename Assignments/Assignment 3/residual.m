function y = residual(x, A, B)

xa1 = x(1);
xb1 = x(2);

g = gammas(x, A, B);

galpha = g(1, :);
gbeta = g(2, :);

ga1 = galpha(1); ga2 = galpha(2);
gb1 = gbeta(1); gb2 = gbeta(2);

y = [
    log(ga1/gb1) + log(xa1/xb1);
    log(ga2/gb2) + log((1-xa1)/(1-xb1));
    ];

end