function [xs] = incsearch(fun, xi, xf, dxo)
% Finds two points on either side of a root

xold = xi;
xnew = xold;
yold = feval(fun, xold);
xs = zeros(1, 3);

while xnew <= xf % Before we reach end of interval
    dyold = 1e12;
    sing=0;    

    xnew = xold + dxo; % Increment x
    ynew = feval(fun, xnew); % New y-value
    if ynew == 0 % If root found
        break
    elseif sign(ynew * yold) == 1 || sign(ynew * yold) == 0 % No root found, step over
        xold = xnew;
        yold = ynew;
    else % Root between y-old and y-new
        dy = abs(yold - ynew);
        if dy > dyold % Checking for singularities
            sing = 1;
            break
        end
        xs = [xold, xnew];
        break
    end 

end

end