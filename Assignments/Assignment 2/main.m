clear
clc

Bim = [0.01, 0.1, 1, 10, 1000];
Fom = [0, 2];

% brent on hygroscopicity

h = @(x)hygro(10, x);
[z, ns] = brent(h, 0, 10000, 0.01, 1e-12);

size(z)
ns

% create matrix of concentration values using these roots

% print time for something