function [y] = trapezoid(func, yi, b, n, h, tol)
% Implicit Trapezoid
% func = % stacked function vector
% yg = array of initial guesses
% a, b = interval endpoints
% n = number of points
% h = step size
% tol = tolerance
% yn = output
%% Initialization

m = length(yi);
y = zeros(m, n);

y(:, 1) = yi(:);

for i = 1:n-1
    k = 0;
    yg = y(:, i) + h;
    check = 1;
    dfold = 1e10;
    ov = ones(1, m);
    
    r = @(yf)residualtrap(func, y(:, i), yf, h);
    
    while tol < check
        
        k = k + 1;
        rv = r(yg); % Evaluate residual vector
        jf = jacob(func, yg, h); % Compute Jacobian of function (jf)
        jr = eye(m) - h*jf/2; % Get Residual Jacobian by identity - jf
        yn = yg - gelim(jr, rv); % Generate new guess
        
        df = ov * abs(r(yn) - rv);
        
        if k > 100 || (df > dfold && k > 1) || ~isreal(yn)
            warning('Method failed after %1.0f iterations, solution may be incorrect!!', k - 1);
            break
        end

        check = ov * abs(yn - y(:, i)) / m;
        yg = yn;
        
    end
    
    y(:, i + 1) = yn;
    
end