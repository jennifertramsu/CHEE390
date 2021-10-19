% Ngan Jennifer Tram Su [260923530]

% Main Program - Plotting Van Laar activity coefficients

%% Initialization

Tc = 125;
T = linspace(20, 125, 500);
S = zeros(length(T), 3);
xg = [0.015, 0.985];

%% Iterate over temperature to obtain new van Laars constants

for t = 1:length(T)
    xn = zeros(1, 2);
    % Determine other parameters using initial guesses
    g = gammas(xg, T(t), Tc);
    
    r = @(x) residual(x, g);
    xn = newtonrm(r, xg, 1e-10, 1e-12);
    S(t, :) = [T(t), xn(1), xn(2)];
    xg = [xn(1), xn(2)]; % Zero-order continuation
end

S