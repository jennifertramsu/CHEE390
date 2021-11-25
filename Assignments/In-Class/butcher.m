function [y] = butcher(yi, func, a, b, n)
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

y(:, 1) = yi;

for i=1:n-1
    k1=dx*func(y(:,i));
    k2=dx*func(y(:,i)+k1/4);
    k3=dx*func(y(:,i)+(k1+k2)/8);
    k4=dx*func(y(:,i)-k2/2+k3);
    k5=dx*func(y(:,i)+(3*k1+9*k4)/16);
    k6=dx*func(y(:,i)+(-3*k1+2*k2+12*k3-12*k4+8*k5)/7);
    y(:,i+1)=y(:,i)+(7*k1+32*k3+12*k4+32*k5+7*k6)/90;
end

end
