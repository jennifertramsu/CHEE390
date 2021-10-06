function rt = bisection(func, xi, xf, dxo, tol)

xi = xi - dxo;
x1 = xi + dxo;
y1 = func(xi);
x2 = xf;
y2 = func(xf);
check = 1;

while check > tol

    x3 = (x1 + x2) / 2;
    y3 = func(x3);
    
    if sign(y1 * y3) == -1
        x2 = x3;
        y2 = y3;
    else
        x1 = x3;
        y1 = y3;
    end
    
    % VERIFY CHECK
    if abs(x3) < eps
        check = abs(x3); % Absolute error
    else
        check = abs(1 - x1/x2);
    end

end

rt = x3;

end