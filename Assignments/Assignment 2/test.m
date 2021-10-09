clear
clc

[r, s] = brent(@(x)x*cot(x^1.5), 0, 20, 1e-4, 1e-12);
size(r)
s

[r, s] = brent(@(x)sin(x^2), 0, 300, 1e-4, 1e-12); % really long time when dx = 1e-2
size(r)
s

[z, s] = brent(@(x)x, -1, 1, 1e-2, 1e-12)
[z, s] = brent(@(x)x^2-1, -1, 1, 1e-2, 1e-12)
[z, s] = brent(@(x)x^3, -1, 1, 1e-2, 1e-12)
[z, s] = brent(@(x)sin(x), -pi/2, pi/2, 1e-2, 1e-12)
[z, s] = brent(@(x)tan(x), -pi/2, pi/2, 1e-2, 1e-12)
[z, s] = brent(@(x)1/x, -1, 1, 1e-2, 1e-12)
[z, s] = brent(@(x)x*cot(x), -5, 5, 1e-2, 1e-12)