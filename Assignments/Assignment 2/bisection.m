function [rt, bifail] = bisection(func, xl, xr, tol)

yl = feval(func, xl);
yr = feval(func, xr);

dy = abs(yl - yr);

bifail = 0;
check = 1;

while check > tol

    xmid = (xl + xr) / 2;
    ymid = feval(func, xmid);
    
    if sign(yl * ymid) == -1
        xr = xmid;
        yr = ymid;
    elseif sign(yr * ymid) == -1
        xl = xmid;
        yl = ymid;
    elseif ymid == 0
        rt = xmid;
        return
    elseif yl == 0
        rt = xl;
        return
    elseif yr == 0
        rt = xr;
        return
    else
        bifail = 1;
        break
    end
    
    dynew = abs(yl - yr);
    
    if dynew >= dy
        bifail = 1;
        break
    end
    
    if abs(xr) < 1 % use x to avoid floating point errors in y --> if aggressive slope, need more precision for y values to converge
        check = abs(xr-xl); % Absolute error
    else
        check = abs(1 - xl/xr); % Relative error
    end

end

if check < tol && bifail == 0
    rt = xr; % Convention is to take right boundary
else
    rt = NaN;
end

end