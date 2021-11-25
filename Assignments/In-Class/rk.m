function [y] = rk(func, x, yi, tol, order)
% Family of ODE solvers - Butcher's, Implicit Backwards Euler, Trapezoid
% func = % stacked function vector
% yi = array of initial guesses
% tol = tolerance
% order = ODE solver ([1] euler, [2] trapezoid, [3] Butcher's)
% y = output
%% Initialization
n = length(x);
m = length(yi);
y = zeros(m, n);
y(:, 1) = yi(:);
h = diff(x);

%% ODE Solvers
if order == 3
    
    for i=1:n-1
        
        k1=h(i)*func(y(:,i));
        k2=h(i)*func(y(:,i)+k1/4);
        k3=h(i)*func(y(:,i)+(k1+k2)/8);
        k4=h(i)*func(y(:,i)-k2/2+k3);
        k5=h(i)*func(y(:,i)+(3*k1+9*k4)/16);
        k6=h(i)*func(y(:,i)+(-3*k1+2*k2+12*k3-12*k4+8*k5)/7);
        y(:,i+1)=y(:,i)+(7*k1+32*k3+12*k4+32*k5+7*k6)/90;
        
    end
else
    
    for i = 1:n-1
        k = 0;
        yg = y(:, i);
        check = 1;
        ov = ones(1, m);
        
        if order == 1
            r = @(yf)residual(func, y(:, i), yf, h(i));
        elseif order == 2
            r = @(yf)residualtrap(func, y(:, i), yf, h(i));
        end
        while tol < check
            
            k = k + 1;
            rv = r(yg); % Evaluate residual vector
            jf = jacob(func, yg); % Compute Jacobian of function (jf)
            
            if order == 1
                jr = eye(m) - h(i)*jf; % Get Residual Jacobian by identity - jf
            elseif order == 2
                jr = eye(m) - h(i)*jf/2;
            end
            
            yn = yg - gelim(jr, rv); % Generate new guess
            
            if k > 100
                warning('Method failed after %1.0f iterations, solution may be incorrect!!', k - 1);
                break
            end
            
            check = ov * abs(yn - yg) / m;
            yg = yn;
            
        end
        
        y(:, i + 1) = yn;
    end
    
end