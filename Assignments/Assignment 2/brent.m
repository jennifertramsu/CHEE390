function [z] = brent(func, xo, xf, tol)
% This algorithm implements Brent's root finding method
% func = function to be searched
% xo = start of interval
% xf = end of interval
% tol = tolerance
% [r] = array of roots to be returned
%% Initialization
z = zeros(1000, 1); % array of roots to be returned
n = 0; % keeping track of number of roots found
x = xo;
dxo = 1e-2;
%% Start of outer while loop - Ensures that function searches entire interval
while x <= xf
    % --> conditions: x < xf
    %% Find x1 and x3 through incremental search
    xs = incsearch(func, x, xf, dxo);
    s = size(xs);
    
    if s(2) == 3 % No more roots found
        break
    elseif s(2) == 1
        n = n + 1;
        z(n) = xs;
        x = x + dxo;
        continue
    end
    
    x1 = xs(1); y1 = func(x1);
    x3 = xs(2); y3 = func(x3);
    
    %% Locate x2 with bisection method
    x2 = (x1*y3 - x3*y1)/(y3 - y1);
    y2 = func(x2);
    
    check = 1; % Initialize check
    
    %% Start of inner while loop - Brent's Method
    while check > tol && x1 < xf
        % --> conditions: check < tol
        % Find a better estimate of the root, x4
        r = y2/y3;
        s = y2/y1;
        t = y1/y3;
        
        p = s*(t*(r - t)*(x3 - x2) - (1 - r)*(x2 - x1));
        q = (r-1)*(s-1)*(t-1);
        
        x4 = x2 + p/q;
        y4 = func(x4);
        
        % If x4 is NaN, don't bother with while --> check with bisection
        if isnan(x4)
            rt = bisection(func, x1, x3, dxo, tol);
            n = n + 1;
            z(n) = rt;
            break
        end
        
        check = abs((p/q)/x4);
        
        if (check < tol && x <= xf) || y4 == 0
            n = n + 1;
            z(n) = x4;
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
        
    end
    
    % Verify root with another method
    rt = bisection(func, x1, x3, dxo, tol);
    
    if isnan(rt) % Singularity was just added, remove
        z(n) = 0;
        n = n - 1;
    end
        
    x = x3 + dxo;
    
end

% Empty out unused array
z(n + 1:end) = [];
end