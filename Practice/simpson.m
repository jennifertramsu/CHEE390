function a = simpson(y, a, b, p)
% Simpson's Rule for integration
% y = function handle
% h = step size
% n = number of points (n - 1 intervals)

%% Error Handling
if mod(p, 2) == 0
    error('n must be odd!');
end

%% Initialization
h = (y(b)- y(a)) / (p - 1);
even = 0;
odd = 0;

%% Looping
dx = linspace(a, b, p);

for i = 2:2:p-1
    even = even + y(dx(i));
end

for j = 3:2:p-2
    odd = odd + y(dx(j));
end

%% Final
a = h/3 * (y(a) + y(b) + 4*even + 2*odd);

end