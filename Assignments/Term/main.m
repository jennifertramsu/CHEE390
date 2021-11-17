% Ngan Jennifer Tram Su
% 260923530

% 1 = isobutane
% 2 = carbon dioxide

%% Initialization
R = 8.314; % m3 Pa K−1 mol−1
Tc = [407.7, 304.13]; % K
Pc = [3650e3, 7.3773e6]; % Pa;

% http://www.kaylaiacovino.com/Petrology_Tools/Critical_Constants_and_Acentric_Factors.htm
w = [0.183, 0.239];

k = [
    0 0.130;
    0.130 0
    ]; % Interaction parameters

z = [0.1, 0.9];
N = length(z); % Number of species
z = z ./ (z * ones(N, 1)); % Normalize z

theta = zeros(1, length(P));

%% Calculating Mixing Parameters at Critical Point
ac = 0.45724 * R^2 .* Tc.^2 ./ Pc;
b = 0.07780 * R * Tc ./ Pc;

%% Read in pressure and temperature
P = linspace(689476, 6.895e6, 500);
T = 310.928; % K

%% Calculate Mixing Parameters for All Other Points
const = 0.37464 + 1.54226*w - 0.26992*w.^2;
dima = sqrt(1 + const.*(1 - sqrt(T./Tc))); % Dimensionless parameter to determine a
a = ac .* dima;

%% Guess initial K-factors
K = wilson(Pc, P(1), Tc, T, w);

%% Iteration

for p = 1:length(P)
    
    r = @(v) vapfrac(v, z, K);
    
    if sign(r(0)*r(1)) <= 0
        alp = newtonrm(r, 0.5, 1e-3, 1e-12);
        nphase = 2;
    elseif r(0) <= 0
        alp = 0;
        nphase = 1;
    elseif r(1) >= 0
        alp = 1;
        nphase = 1;
    else
        % print error message
        error('what');
    end
    
    %% Solving for vapour and liquid compositions
    x = z ./ (1 + alp.*(K - 1));
    y = K .* x;
    
    % Normalizing x and y
    x = x ./ (x * ones(length(x), 1));
    y = y ./ (y * ones(length(y), 1));
    
    bv = (y.*b) * ones(N, 1);
    bl = (x.*b) * ones(N, 1);
    
    av = 0;
    al = 0;
    
    for i = 1:N
        for j = 1:N
            av = av + y(i)*y(j)*sqrt(a(i)*a(j))*(1 - K(i, j));
            al = al + x(i)*x(j)*sqrt(a(i)*a(j))*(1 - K(i, j));
        end
    end
    
    %% Solving for molar volumes of each species
    
    % ? what
    V = ...;
    
    vv = max(V); % Vapour volume is largest root
    vl = min(V); % Liquid volume is smallest root
    
    %% Fugacities
    
    % stuff
    fv = ...;
    fl = ...;
    
    theta(k) = (y .* log(fv ./ fl)) * ones(N, 1);
    
    % I have no idea what's happening after this point
    
end
