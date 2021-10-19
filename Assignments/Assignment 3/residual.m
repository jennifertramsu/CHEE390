function y = residual(x, g)

x1 = x(1); g1 = g(1);
x2 = x(2); g2 = g(2);

y = [
    log(g1/g2) + log(x1/x2);
    log(g2/g1) + log((1-x1)/(1-x2));
    ];

end