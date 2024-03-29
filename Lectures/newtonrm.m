% Lecture 6 - Sept. 21, 2021

function [xn, nrfail] = newtonrm(fun, xg, xl, xr, tol)
% Newton Raphson method for calculating root in the interval xrg = [x1 xr]
% xg = guess, point where straight line connecting end-points crosses the x-axis
% xl = left
% xr = right

i=0; % Counter, usually 10
nrfail=0; % Flag, calls another method to verify that point is root or singularity
check=1; % To get inside the while loop
h=1e-4; % Never any bigger

% Loop

while tol < check
    i=i+1;
    fp=der(fun,xg,h);
    y=feval(fun,xg);
    xn=xg-y/fp; % xn = new guess, where slope intersects the x-axis
    
    if xn<xl || xn>xr || i>10 || fp==0 % NR method has failed
        nrfail=1;
        break
    end
    
    if abs(xn) <= 1 % Otherwise, check will blow up bc small denominator
        check=abs(xg-xn); % Absolute error
    else
        check=abs(1-xg/xn); % Relative error
    end
    
    xg=xn; % Update guess
end

end