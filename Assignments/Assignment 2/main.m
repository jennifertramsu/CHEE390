clear
clc
% initialize dimension values or wtv
Bim = [0.01, 0.1, 1, 10, 1000];
Fom = [0, 2];

r = brent(@(x)x*cot(x^1.5), 0, 20, 1e-12);
size(r)

r = brent(@(x)sin(x^2), 0, 300, 1e-12);
size(r)

brent(@(x)x, -1, 1, 1e-12)
brent(@(x)x^2-1, -1, 1, 1e-12)
brent(@(x)x^3, -1, 1, 1e-12)
brent(@(x)sin(x), -pi/2, pi/2, 1e-12)
%brent(@(x)tan(x), -pi/2, pi/2, 1e-12)

% brent on hygroscopicity

% create matrix of concentration values using these roots

% print time for something