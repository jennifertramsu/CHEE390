xg = [1, 1, 1];

newtonrm(@(x)fun(x), xg, 1e-2, 1e-12)

function f = fun(x)

x1 = x(1);
x2 = x(2);
x3 = x(3);


f = [-2*x1 + 5*x2 + x2^2 * sin(x1) + x3^2;
    2*x1 + x2 + 11*x1*x2^3 + x3^3;
    x3 - 102*x1*x2*x3^13];

end