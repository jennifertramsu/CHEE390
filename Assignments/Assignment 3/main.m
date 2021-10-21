% Ngan Jennifer Tram Su [260923530]

% Main Program - Plotting Van Laar activity coefficients

%% Initialization

Tc = 125 + 273.15; % K
T = linspace(Tc, 20 + 273.15, 500); % decreasing from 125 to 20 deg C
S = zeros(length(T), 3);
xg = [0.37, 0.37];
dx = 0.02;

S(1, :) = [T(1), xg(1), xg(2)];
xg = [xg(1) - dx, xg(2) + dx];

%% Iterate over temperature to obtain new van Laars constants

for t = 2:length(T)
    xn = zeros(1, 2);
    
    % Determine other parameters using initial guesses
    
    r = @(x) residual(x, T(t), Tc);
    xn = newtonrm(r, xg, 1e-3, 1e-12);
    S(t, :) = [T(t) - 273.15, xn(1), xn(2)];
    xg = xn; % Zero-order continuation
    
end

S