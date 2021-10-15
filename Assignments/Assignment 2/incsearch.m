function [xs] = incsearch(func, xl, xr, dx)
% Finds two points on either side of a root
% xl = left bound
% xr = right bound

xl = xl - dx;

xold = xl + dx; 
yold = feval(func, xl);

xnew = xold;

xs = zeros(1, 3);

while xnew < xr % Before we reach end of interval
    
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