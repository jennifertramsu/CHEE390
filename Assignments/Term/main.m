% Ngan Jennifer Tram Su
% 260923530

clear
clc

% 1 = carbon dioxide
% 2 = isobutane

%% Initialization
R = 8.314; % m3 Pa K−1 mol−1
Tc = [304.13, 407.7]; % K
Pc = [7.3773e6, 3650e3]; % Pa;

% http://www.kaylaiacovino.com/Petrology_Tools/Critical_Constants_and_Acentric_Factors.htm
w = [0.239, 0.183];

k = [
    0 0.130;
    0.130 0
    ]; % Interaction parameters

z = [0.01, 0.99]; % doesn't work when # P points is 100 --> step size too large
N = length(z); % Number of species
z = z ./ (z * ones(N, 1)); % Normalize z

%% Calculating Mixing Parameters at Critical Point
ac = 0.45724 * (R*Tc).^2 ./ Pc;
bp = 0.07780 * (R*Tc) ./ Pc;

%% Read in pressure and temperature
P = linspace(500000, 6.9e6, 1000);
T = 310.928; % K

%% Calculate Mixing Parameters for All Other Points
const = 0.37464 + 1.54226*w - 0.26992*w.^2;
dima = (1 + const.*(1 - sqrt(T./Tc))).^2; % Dimensionless parameter to determine a
ap = ac .* dima;

xsol = zeros(length(P), N);
ysol = zeros(length(P), N);
psol = zeros(length(P), 1);

%% Iteration
p = 1;

f = @(z, P, K)flash(z, P, T, k, ap, bp, K);

%% Guess initial K-factors
K = wilson(Pc, P(1), Tc, T, w);
dx = 1e-3; % Any smaller and it doesn't converge fast enough

while p <= length(P)
    
    [x, y, alp, K, err] = f(z, P(p), K);
%     
%     if err == 1
%         % In liquid or vapour
%         if alp == 1 % all vapour
%             z = [z(1) - dx, z(2) + dx]; % Reduce system comp of 1
%         elseif alp == 0 % all liquid
%             z = [z(1) + dx, z(2) - dx]; % Increase system comp of 1
%         end
%         z = z ./ (z * ones(N, 1)); % Normalize z
%     else
%         if alp < 0.2
%             z = [z(1) + dx, z(2) - dx];
%             z = z ./ (z * ones(N, 1)); % Normalize z
%         end
%     end

    if alp < 0.2 && err == 0
        z = [z(1) + dx, z(2) - dx];
        z = z ./ (z * ones(N, 1)); % Normalize z
    elseif err == 1
        if alp == 1 % all vapour
            z = [z(1) - dx, z(2) + dx]; % Reduce system comp of 1
        elseif alp == 0 % all liquid
            z = [z(1) + dx, z(2) - dx]; % Increase system comp of 1
        end
        z = z ./ (z * ones(N, 1)); % Normalize z
    end

    xsol(p, :) = x;
    ysol(p, :) = y;
    psol(p) = P(p);
    p = p + 1;
    
    if z(1) == 0
        z(1) = 0.01 + dx;
        z = z ./ (z * ones(N, 1)); % Normalize z
    end
    
end

%% Crappy Plotting

figure(1)

xlabel('Composition of Carbon Dioxide')
ylabel('Pressure (Pa)')

hold on

plot(xsol(:, 1), psol);
plot(ysol(:, 1), psol);

hold off

