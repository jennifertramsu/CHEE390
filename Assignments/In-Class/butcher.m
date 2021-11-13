function [x, y] = butcher(yi, func, a, b, n)
% Algorithm that implements a 5th order RK method
% p = array of initial x and y guess
% func = function handle
% a, b = interval endpoints
% n = number of steps
% y = output array

%% Initialization

[m, ~] = size(yi);

y = zeros(m, n); 

dx = (b - a) / (n - 1);

x(1) = yi(end);
y(:, 1) = yi;

for i = 1:n-1
    
    k1 = dx*func(y(:, 1));
    k2 = dx*func(y(:, i) + k1/4);
    k3 = dx*func(y(:, i) + k1/8 + k2/8);
    k4 = dx*func(y(:, i) - k2/2 + k3);
    k5 = dx*func(y(:, i) + 3*k1/16 + 9*k4/16);
    k6 = dx*func(y(:, i) + (-3*k1 + 2*k2 + 12*k3 - 12*k4 + 8*k5)/7);
    ynew = y(:, i) + (7*k1 + 32*k3 + 12*k4 + 32*k5 + 7*k6)/90;
    
    y(:, i + 1) = ynew; % Store in array
        
end

y = y(1:end - 1, :);
x = y(end, :);

end
