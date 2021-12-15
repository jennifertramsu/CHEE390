function [rt, bifail, sing] = bisection(func, xl, xr, tol)
% This function implements the bisection root finding method
% func = residual function of interest
% xl = left bound
% xr = right bound
% tol = tolerance
% rt = root
% bifail = flag for fail
% sing = flag for singularity

%% Initialization
yl = feval(func, xl);
yr = feval(func, xr);

dy = abs(yl - yr);

bifail = 0;
check = 1;
sing = NaN;

%% Beginning of while loop
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
    else % Maybe NaN
        bifail = 1;
        break
    end
    
    dynew = abs(yl - yr); % Check new dy
    
    if dynew >= dy % Singularity :')
        bifail = 1;
        break
    end
    
    if abs(xr) < 1 % Use x to avoid floating point errors in y --> if aggressive slope, need more precision for y values to converge
        check = abs(xr-xl); % Absolute error for small xr
    else
        check = abs(1 - xl/xr); % Relative error
    end

end

%% Final Check
if check < tol && bifail == 0
    rt = xr; % Convention is to take right boundary
else
    rt = NaN; % Just so rt has some return value
end

end