function y = residual(x, A, B)
% Defines the objective functions for a binary liquid system obeying the van
% Laar coefficient model
% x = array of compositions [xa1, xb1]
% A = constant (a/T)
% B = constant (b/T)
% y = array of objective functions [f, g]

xa1 = x(1);
xb1 = x(2);

g = gammas(x, A, B); % Calculating the activities

galpha = g(1, :); % First row for alpha-phase
gbeta = g(2, :); % Second row for beta-phase

ga1 = galpha(1); ga2 = galpha(2);
gb1 = gbeta(1); gb2 = gbeta(2);

y = [
    log(ga1/gb1) + log(xa1/xb1); % f
    log(ga2/gb2) + log((1-xa1)/(1-xb1)); % g
    ];

end