function [y, A, B] = pengr(Z, a, b, T, P)
% Re-arranged Peng-Robinson equation
% Z = compressibility factor
% a = 
% b = 
% T = temperature
% P = pressure

R = 8.314; % m3 Pa K−1 mol−1
A = a*P / (R*T)^2;
B = b*P / (R*T);

y = Z^3 - (1 - B)*Z^2 + (A - 3*B^2 - 2*B)*Z - (A*B - B^2 - B^3);

end
