function [rt, bifail] = bisection(func, xi, xf, tol)

x1 = xi; y1 = feval(func, x1);
x2 = xf; y2 = feval(func, xf);

dy = abs(y1 - y2);

bifail = 0;
check = 1;

while check > tol

    x3 = (x1 + x2) / 2;
    y3 = feval(func, x3);
    
    if sign(y1 * y3) == -1
        x2 = x3;
        y2 = y3;
    else
        x1 = x3;
        y1 = y3;
    end
    
    dynew = abs(y1 - y2);
    
    if dynew > dy
        bifail = 1;
        break
    end
    
    % VERIFY CHECK
    if abs(x2) < 1
        check = abs(x2); % Absolute error
    else
        check = abs(1 - x1/x2);
    end

end

rt = x3;

end