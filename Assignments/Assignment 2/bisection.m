function [x2, y2] = bisection(func, x1, x3)

x2 = (x1 + x3)/2;
y2 = func(x2);

end