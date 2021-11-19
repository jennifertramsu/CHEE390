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

z = [0.5, 0.5];
N = length(z); % Number of species
z = z ./ (z * ones(N, 1)); % Normalize z

%% Calculating Mixing Parameters at Critical Point
ac = 0.45724 * R^2 * Tc.^2 ./ Pc;
b = 0.07780 * R * Tc ./ Pc;

%% Read in pressure and temperature
P = linspace(Pc(2), Pc(1), 500);
T = 310.928; % K

theta = zeros(1, length(P));

%% Calculate Mixing Parameters for All Other Points
const = 0.37464 + 1.54226*w - 0.26992*w.^2;
dima = sqrt(1 + const.*(1 - sqrt(T./Tc))); % Dimensionless parameter to determine a
a = ac .* dima;

%% Guess initial K-factors
K = zeros(length(P), N);
K(1, :) = wilson(Pc, P(1), Tc, T, w);

%% Iteration

for p = 1:length(P)
    
    r = @(v) vapfrac(v, z, K);
    
    if sign(r(0)*r(1)) <= 0
        alp = newtonrm(r, 1, 1e-3, 1e-12);
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
    x = z ./ (1 + alp.*(K(p, :) - 1));
    y = K(p, :) .* x;
    
    % Normalizing x and y
    x = x ./ (x * ones(N, 1));
    y = y ./ (y * ones(N, 1));
    
    bv = (y.*b) * ones(N, 1);
    bl = (x.*b) * ones(N, 1);
    
    av = 0;
    al = 0;
    
    for i = 1:N
        for j = 1:N
            av = av + y(i)*y(j)*sqrt(a(i)*a(j))*(1 - k(i, j));
            al = al + x(i)*x(j)*sqrt(a(i)*a(j))*(1 - k(i, j));
        end
    end
    
    %% Solving for molar volumes of each species --- need to check if roots are real
    Av = av*P(p) / (R*T)^2;
    Bv = bv*P(p) / (R*T);
    r1 = [1, -(1 - Bv), Av - 3*Bv^2 - 2*Bv, -(Av*Bv - Bv^2 - Bv^3)];    
    Zv = roots(r1);
    
    Al = al*P(p) / (R*T)^2;
    Bl = bl*P(p) / (R*T);
    r2 = [1, -(1 - Bl), Al - 3*Bl^2 - 2*Bl, -(Al*Bl - Bl^2 - Bl^3)];    
    Zl = roots(r2);
    
    Zv = max(Zv);
    Zl = min(Zl);
    
    vv = Zv*R*T/P(p);
    vl = Zl*R*T/P(p);
    
    %% Fugacities
    fv = fugacity(x, a, b, Zv, Av, Bv, k, P(p));
    fl = fugacity(y, a, b, Zl, Al, Bl, k, P(p));
    
    theta(p) = (y .* log(fv ./ fl)) * ones(N, 1);
    
    if theta(p) <= 1e-7
        % flash converged!
        return
    else
        if p == 1
            K(p + 1, :) = K(p, :) .* (fl./fv);
        else
            if abs(theta(p) - theta(p - 1)) <= 1e-8
                if theta(p) > 0
                    if alp ~= 0
                        alert('should be liquid');
                    end
                else
                    if alp ~= 1
                        alert('should be vapour');
                    end
                end
            end                    
        end
        
        if nphase ~= 2 
            K(p + 1, :) = K(p, :) .* exp(theta(p));
        end
    end
    
end
