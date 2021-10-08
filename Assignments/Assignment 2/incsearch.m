function [xs] = incsearch(func, xi, xf, dxo)
% Finds two points on either side of a root

xold = xi;
xnew = xold + dxo; % Increment x

yold = feval(func, xold);
ynew = feval(func, xnew); % New y-value

xs = zeros(1, 2);

while sign(ynew * yold) == 1 && xnew < xf % Before we reach end of interval

    xold = xnew;
    yold = ynew;
    
    xnew = xold + dxo;
    ynew = feval(func, xnew);

end

xs = [xold, xnew];

end