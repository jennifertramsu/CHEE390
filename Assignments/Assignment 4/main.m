% Ngan Jennifer Tram Su 260923530
% Main Program that solves for the velocity profile of a Newtonian fluid
% undergoing laminar, pressure-driven flow between two infinite parallel
% flat plates separated by a distance B

% Instructions to run: Press Run, and input vo, vb, and dpdx in command
% window as prompted

clear
clc

%% Inputting conditions

p = 1e3; % kg/m^3
mu = 1e-3; % Pa s
B = 1e-3; % m 
vo = input('Please input the velocity at y = 0 (m/s): ');
vb = input('Please input the velocity at y = B (m/s): ');
dpdx = input('Please input the pressure gradient (Pa/m): ');

%% Initialization
n = 50;
dx = B / n; % 50 - 1 = 49 points

% Tridiagonal  -- matrix | constant matrix
m = zeros(n-1, n);

% First row

m(1, [1:2, end]) = [-2*mu/(dx^2), mu/(dx^2), dpdx - (mu*vo)/(dx^2)];

% Last row

m(end, end-2:end) = [mu/(dx^2), -2*mu/(dx^2), dpdx - (mu*vb)/(dx^2)];

% All other rows

for i = 2:n-2
    m(i, [i-1, i, i + 1, end]) = [mu/(dx^2), -2*mu/(dx^2), mu/(dx^2), dpdx];
end

% Extracting, a, b, c, d

[a, b, c, d] = thomasprep(m, n);

% Call Thomas Algorithm

v = thomas(a, b, c, d);

v = [vo v vb]; % Appending boundary conditions

%% Crappy Plotting
% y = linspace(0, B, n+1);
% plot(y, v);

%% Calculating Average Velocity

% After some simplification, v_av = integral(vx) dy / B

v_av = simpson(v, 0, B, n+1) / B;

fprintf('The average velocity is %.3e m/s.\n', v_av);

%% Calculating Reynold's number

Re = p*v_av*B/mu;

fprintf('The Reynold''s numbers is %.5f.\n', Re);