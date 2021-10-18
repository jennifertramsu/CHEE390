function y = d5(f, xg, h)

x1 = xg + h;
x2 = xg - h;
x3 = xg + 2*h;
x4 = xg - 2*h;

y = (-f(x3) + 8*f(x1) - 8*f(x2) + f(x4)) / (12 * h);

end