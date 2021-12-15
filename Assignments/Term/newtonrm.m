function xn = newtonrm(fun, d, xg, tol)
% Newton Raphson method for calculating root 
% fun = function to evaluate
% d = known derivative
% xg = guess, point where straight line connecting end-points crosses the x-axis
% tol = tolerance
% xn = new point

i=0; % Counter, usually 10
check=1; % To get inside the while loop

% Loop

while tol < check
    i=i+1;
    fp = d(xg); % Known derivative
    y=feval(fun,xg);
    xn=xg-y/fp; % xn = new guess, where slope intersects the x-axis
    
    if i > 10
        warning('Method failed after %1.0f iterations, solution may be incorrect!!', i - 1);
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