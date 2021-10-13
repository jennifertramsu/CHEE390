function [z, ns] = brent(func, xi, xf, dx, tol)
% This algorithm implements Brent's root finding method
% func = function to be searched
% xi = start of interval
% xf = end of interval
% dx = step size
% tol = tolerance
% z = array of roots to be returned
%% Initialization
z = zeros(1000, 1); % array of roots to be returned
n = 0; % Keeping track of roots found
x = xi; % Beginning of interval
ns = 0;
%% Start of outer while loop -- to search the entire interval
while x < xf
    xs = incsearch(func, x, xf, dx);
    nxs = size(xs);
    
    if nxs(2) == 3 % End of interval reached
        break
    end
    
    x1 = xs(1); y1 = feval(func, x1);
    x3 = xs(2); y3 = feval(func, x3);
    
    % Find third point with linear interpolation
    x2 = (x1*y3 - x3*y1)/(y3 - y1);
    y2 = feval(func, x2);
    
    % Initialize check
    check = 1;
    
    %% Start of inner while loop - Brent's Method
    % Initialize counter and flag
    i = 0;
    brfail = 0;
    
    while check > tol && x2 <= xf 
        % --> conditions: check < tol, x2 still inside interval
        % Find a better estimate of the root, x4
        r = y2/y3;
        s = y2/y1;
        t = y1/y3;
        
        p = s*(t*(r - t)*(x3 - x2) - (1 - r)*(x2 - x1));
        q = (r-1)*(s-1)*(t-1);
        
        x4 = x2 + p/q;
        y4 = feval(func, x4);
        
        if isnan(x4) % q is zero
            brfail = 1;
            break
        end
        
        check = abs((p/q)/x4);

        if check < tol && x <= xf % Success!
            break
        elseif x1 < x4 && x4 < x2
            x3 = x2;
            y3 = y2;
        else
            x1 = x2;
            y1 = y2;
        end

        x2 = x4;
        y2 = y4;
        
        i = i + 1;

        if i >= 15
            brfail = 1; % Brent's failed, call bisection
            break
        end
        
        if x2 > x3 % If x2 blows up from floating-point error
            brfail = 1;
            break
        end
    end
    
    if brfail == 0 && x2 <= xf % RETURN TO THIS
        n = n + 1;
        z(n) = x4;
    else
        [rt, bifail] = bisection(func, x1, x3, tol);
        if bifail == 0
            n = n + 1;
            z(n) = rt;
        else
            ns = ns + 1;
        end
    end
    
    x = x3 + dx; % Increment x after x3 for next root      
    
end

% Empty out unused array
z(n + 1:end) = [];

end