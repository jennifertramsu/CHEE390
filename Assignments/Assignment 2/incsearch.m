function [xs] = incsearch(fun, xi, xf, dxo)
% Finds two points on either side of a root

xi = xi - dxo;
xold = xi + dxo;
xnew = xold;
xft = xf + dxo;
yold = feval(fun, xi);
xs = zeros(1, 3);

% If yold happens to be a root
if yold == 0
    xs = xold;
    return
end

while xnew <= xft % Before we reach end of interval
    
    xnew = xold + dxo; % Increment x
    ynew = feval(fun, xnew); % New y-value
    if ynew == 0 % If ynew happens to be root
        xs = xnew;
        return       
    elseif sign(ynew * yold) == 1 % No sign change, continue
        xold = xnew;
        yold = ynew;
    else % Sign change found
        xs = [xold, xnew];
        break
    end 

end

end