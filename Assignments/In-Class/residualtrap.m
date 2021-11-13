function [r] = residualtrap(func, yi, yf, h)

r = yf - yi - h*(func(yi) + func(yf))/2;

end