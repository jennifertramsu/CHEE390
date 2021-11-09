f = @(x)x;
x = linspace(0, 1, 500);
y = f(x);

a = simpson(y, 51);
a