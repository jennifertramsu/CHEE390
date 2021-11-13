function [r] = residual(func, yi, yf, h)

r = yf - yi - h*func(yf);

end
