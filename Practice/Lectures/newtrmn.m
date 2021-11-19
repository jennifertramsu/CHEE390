% Lecture 9 - Sept. 30, 2021

function [xn, y, i] = newtrmn(fun, xg, h, tol)
% Newton-Raphson method for calculating solution to nonlinear set of
% equations
% fun = stacked function (vector)
% xg = initial guesses for each variable ?
% h = small step
% tol = tolerance

% Initializing

i = 0; % counter, number of iterations
check = 1;
n = length(xg); % will tell us size of Jacobian (nxn)
dyold = 1e10; % for divergence in y
ov = ones(1, n); % use at end to compute tolerance check at the end

% Forcing xg to be a column vector

xg = xg(:);

% Loop

while tol < check 
    i = i + 1; % incrementing counter
    j = jacob(fun, xg, h); % Numerical Jacobian
    f = feval(fun, xg);
    % xn = xg - j^-1 * f
    xn = xg - invgjp(j, f); % inverse gauss jordan pivoting -- don't use inverse to calculate solution, use for 1-norm
    % Using 1-norm for dy
    dy = ov * abs(feval(fun, xn) - f); % absolute difference in y-values
    % dot product --> sums up all differences for each function
    
    if i > 100 || (dy > dyold && i > 1) || isreal(xn) == 0 % when dealing with NL systems, some variables converge/diverge faster than others (tug-of-war)
        % some variables converge, but if program ends too soon, other
        % solutions may still be unstable
        % why i > 1? initial guess could be shit
        % when matrix is singular, possible to get complex terms -- need to
        % be in real domain
        warning('Method failed after %1.0f iterations, solution may be incorrect!!', i - 1);
        break
    end
    
    % Creating a scalar value of tolerance using amtrix multiplication
    % (1-norm)
    
    check = ov * abs(xg - xn) / n; % Absolute erro
    xg = xn; % new guess
end
end