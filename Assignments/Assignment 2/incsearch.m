function [xs] = incsearch(fun, xi, xf, dxo)
% Finds two points on either side of a root

xi = xi - dxo;
xold = xi + dxo;
xnew = xold;
xft = xf + dxo;
yold = feval(fun, xi);
xs = zeros(1, 3);

while xnew <= xft % Before we reach end of interval
    dyold = 1e12;
    sing = 0;    

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

if sing == 1
    xs = [];
end

end