% Lecture 5 - Sept. 16, 2021

function [r, nrf] = incsearch(fun, xi, xf, dxo, tol)
% Finds all roots in interval [xi xf]



xold = xi;
yold = feval(fun, xi);
xnew = xi;
nrf = 0; % keeping track of # roots

if yold == 0
    nrf = nrf + 1;
    r(nrf) = xold;
    xold = xold + eps; % avoid using eps, too small
    yold = feval(fun, xold);
end

% initialize more than you need! saves computational time

while xnew <= xf
    dx = dxo;
    
    while tol < dx && xnew <= xf
        xnew = xold + dx;
        ynew = feval(fun, xnew);
        if ynew == 0
            break
        elseif sign(ynew * yold) == 1 || sign(ynew * yold) == 0
            xold = xnew;
            yold = ynew;
        else
            dx = dx/10; % sign change
        end
    end
    
    xold = xnew;
    yold = feval(fun, xold);
    
    if ynew == 0 || dx <= tol
        nrf = nrf + 1;
        r(nrf) = xnew;
        if xold > xf
            r(nrf) = [];
            nrf = nrf - 1;
        end
    end
end