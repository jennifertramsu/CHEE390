% Ngan Jennifer Tram Su [260923530]

clear
clc

% Main Program - Plotting Van Laar activity coefficients

%% Initialization

Tc = 125 + 273.15; % K
T = linspace(Tc, 20 + 273.15, 500); % decreasing from 125 to 20 deg C
S = zeros(length(T), 3);
xg = [0.37, 0.37];
dx = 0.02;

k = (xg(1) * (1 + xg(2))) / (xg(2) * (1 + xg(1)));
a = (Tc * (xg(1) + xg(2)*k)^3) / (2*xg(1)*xg(2)*k^2);
b = a*k;

A = a ./ T;
B = b ./ T;

S(1, :) = [T(1) - 273.15, xg(1), xg(2)];
xg = [xg(1) - dx, xg(2) + dx];

%% Iterate over temperature to obtain new van Laars constants

for t = 2:length(T)
        
    r = @(x) residual(x, A(t), B(t));
    xn = newtonrm(r, xg, 1e-5, 1e-12);
    S(t, :) = [T(t) - 273.15, xn(1), xn(2)]; % Converting temperature to deg C
    xg = xn; % Zero-order continuation
    
end

S