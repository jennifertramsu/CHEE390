function K = wilson(Pc, P, Tc, T, w)
% Wilson equation to determine initial guess for equilibrium constant
% Pc = critical pressure
% P = pressure
% Tc = critical temperature
% T = temperature
% w = acentric factor
% K = equilibrium constant

lnK = log(Pc/P) + 5.37*(1 + w) .* (1 - (Tc/T));
K = exp(lnK);

end
