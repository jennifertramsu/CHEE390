clear
clc

% a = [1 1 1 6; 2 -1 -1 -3; -2 -2 2 0];
% [x, inv] = gelim(a);

% a = [0 -1 0; 1 1 0];
% [x, inv] = gelim(a);

a = [0.0001 1 1; 1 1 2];
[x, inv] = gelim(a);

x
inv