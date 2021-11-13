function y = d5(f, xg, h)
% 5-pt Central Difference
% f = array of functions
% xg = array of initial guesses for each variable
% h = array of small steps
% y = numerator of 5-pt central difference

x1 = xg + h;
x2 = xg - h;
x3 = xg + 2*h;
x4 = xg - 2*h;

y = -f(x3) + 8*f(x1) - 8*f(x2) + f(x4);

end