function r = peng(Z, A, B)
% Peng-Robinson equation of state
% Z = compressibility factor
% A, B = constants
% r = residual output

r = Z^3 -(1 - B)*Z^2 + (A - 3*B^2 - 2*B)*Z - (A*B - B^2 - B^3);

end