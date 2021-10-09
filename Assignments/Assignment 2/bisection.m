function [rt, bifail] = bisection(func, xi, xf, dx, tol)

xi = xi - dx;
x1 = xi + dx; y1 = feval(func, xi);
x2 = xf; y2 = feval(func, xf);

dy = abs(y1 - y2);

bifail = 0;
check = 1;

while check > tol

    x3 = (x1 + x2) / 2;
    y3 = feval(func, x3);

    if abs(y3) < 1
        check = abs(y3); % Absolute error
    else
        check = abs(1 - y1/y3);
    end
    
    if sign(y1 * y3) == -1
        x2 = x3;
        y2 = y3;
    elseif sign(y2 * y3) == -1
        x1 = x3;
        y1 = y3;
    else
        bifail = 1;
        break
    end
    
    dynew = abs(y1 - y2);
    
    if dynew > dy
        bifail = 1;
        break
    end

end

rt = x3;

end