% Ngan Jennifer Tram Su [260923530]

function [xs] = incsearch(func, xl, xr, dx)
% Finds two points on either side of a root
% xl = left bound
% xr = right bound
% xs = array storing end points surrounding sign change
% --> size = [1 2] if sign change was found, otherwise size = [1 3] if no
% sign change was found within interval
%% Initialization
xl = xl - dx; % Accounting for floating point error at beginning of interval
xold = xl + dx; 
yold = feval(func, xl);
xnew = xold;

xs = zeros(1, 3); % Array to store output

%% Beginning of while loop
while xnew < xr % Before we reach end of interval
    
    xnew = xold + dx;
    ynew = feval(func, xnew);
    
    if sign(ynew * yold) == -1 % Success! :)
        xs = [xold, xnew];
        break
    end
    
    xold = xnew;
    yold = ynew;

end

end