function [xn, i] = newtonrm(fun, xg, h, tol)
% Phillip Servio (c) 
% Newton-Raphson method for calculating solution to nonlinear set of
% equations

i = 0;
check = 1;
n = length(xg);
dyold = 1e10;
ov = ones(1, n);

% Forcing xg to be a column vector

xg = xg(:);

% Loop

while tol < check
    i = i + 1;
    j = jacob(fun, xg, h);
    f = feval(fun, xg);
    xn = xg - invgjp(j, f);
    
    dy = ov * abs(feval(fun, xn) - f);
    
    if i > 100 || (dy > dyold && i > 1) || ~isreal(xn)
        warning('Method failed after %1.0f iterations, solution may be incorrect!!', i - 1);
        break
    end
        
    check = ov * abs(xg - xn) / n;
    xg = xn;
    
end

end