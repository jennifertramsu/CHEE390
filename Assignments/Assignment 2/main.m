%%% NOTES

% initialize dimension values or wtv
Bim = [0.01, 0.1, 1, 10, 1000];
Fom = [0, 2];

r = brent(@(x)x^2 - 1, -2, 2, 1e-12)

% brent on hygroscopicity

% create matrix of concentration values using these roots

% print time for something