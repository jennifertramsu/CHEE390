xg = [1, 1];

newtonrm(@(x)fun(x), xg, 1e-2, 1e-12)

function f = fun(x)

x1 = x(1);
x2 = x(2);

f = [x2 - x1;
    x1^2 + x2^2-25;
    ];

end