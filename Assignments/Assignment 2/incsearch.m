function [r, nrf] = incsearch(fun, xi, xf, dxo, tol)
% Finds all roots in interval [xi xf]

xi = xi-dxo; % Accounting for floating-point errors at beginning of interval
xold = xi + dxo;
xnew = xold;
yold = feval(fun, xi);
xft = xf + dxo;
nrf = 0; % keeping track of # roots
r = zeros(1000, 1); % Initialize more than you need! Saves computational time

while xnew <= xft % Before we reach end of interval
    dx = dxo; % Reset x-increment, otherwise increment will be really small
    dyold = 1e12;
    sing=0;
    
    while tol < dx && xnew <= xft % While we haven't reached tolerance or end of interval
        xnew = xold + dx; % Increment x
        ynew = feval(fun, xnew); % New y-value
        if ynew == 0 % If root found
            break
        elseif sign(ynew * yold) == 1 || sign(ynew * yold) == 0 % No root found, step over
            xold = xnew;
            yold = ynew;
        else % Root between y-old and y-new
            %dx = dx/10; % Sign change, decrease increment and continue searching
            dy = abs(yold - ynew);
            if dy > dyold % Checking for singularities
                sing = 1;
                break
            end
            dx = dx / 10;
        end
    end
    % When root is found, breaking out of while-loop
    xold = xnew;
    yold = feval(fun, xold);
    
    if sing == 0 && xnew <= xft
        nrf = nrf + 1;
        r(nrf) = xnew;
        xold = xnew + tol;
    end
end

r(nrf + 1: end) = [];

end