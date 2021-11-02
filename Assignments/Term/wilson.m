function K = wilson(Pc, P, Tc, T, w)
% Function to determine initial guess for equilibrium constant

lnK = log(Pc/P) + 5.37 * (1 + w) * (1 - Tc / T);
K = exp(lnK);

end
