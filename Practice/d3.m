function y = d3(f, xg, h)

x1 = xg + h;
x2 = xg - h;

y = f(x1) - f(x2);

end