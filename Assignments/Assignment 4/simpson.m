function a = simpson(y, p)
% Simpson's Rule for integration
% y = vector
% p = number of points (p - 1 intervals)
% a = computed integral

%% Error Handling
if mod(p, 2) == 0
    error('n must be odd!');
end

%% Initialization
h = (y(end)- y(1)) / (p - 1);
even = 0;
odd = 0;

%% Looping

for i = 2:2:p-1
    even = even + y(i);
end

for j = 3:2:p-2
    odd = odd + y(j);
end

%% Final
a = h/3 * (y(1) + y(end) + 4*even + 2*odd);

end