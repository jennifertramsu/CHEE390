function [xs] = incsearch(func, xi, xf, dx)
% Finds two points on either side of a root

xi = xi - dx;
xold = xi + dx; yold = feval(func, xi);
xnew = xold; ynew = yold;

xs = zeros(1, 3);

while xnew < xf % Before we reach end of interval
    
    xnew = xold + dx;
    ynew = feval(func, xnew);
    
    if sign(ynew * yold) == -1
        xs = [xold, xnew];
        break
    end
    
    xold = xnew;
    yold = ynew;

end

end