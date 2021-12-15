% Ngan Jennifer Tram Su
% 260923530

% Instructions to run: Click run :D

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

% Calculating Mixing Parameters at Critical Point
ac = 0.45724 * (R*Tc).^2 ./ Pc;
bp = 0.07780 * (R*Tc) ./ Pc;

% Two sets of conditions of interest
P1 = linspace(5e5, 6.93e6, 1000); % Pa
P2 = linspace(2e6, 6.1e6, 1000); % Pa
T1 = 310.928; % K
T2 = 377.594; % K

%% Two temperatures
for i = 1:2
    
    z = [0.001, 0.999]; % doesn't work when # P points is 100 --> step size too large
    N = length(z); % Number of species
    z = z ./ (z * ones(N, 1)); % Normalize z
    
    %% Read in pressure and temperature
    
    if i == 1
        P = P1;
        T = T1;
    else
        P = P2;
        T = T2;
    end
    
    % Defining pressure limit used to call bisection
    pin = floor(0.9*length(P));
    plim = P(pin);
    
    %% Calculate Mixing Parameters for All Other Points
    const = 0.37464 + 1.54226*w - 0.26992*w.^2;
    dima = (1 + const.*(1 - sqrt(T./Tc))).^2; % Dimensionless parameter to determine a
    ap = ac .* dima;
    
    xsol = zeros(length(P), N);
    ysol = zeros(length(P), N);
    psol = zeros(length(P), 1);
    
    %% Guess initial K-factors
    Kg = wilson(Pc, P(1), Tc, T, w);
    dx = 1e-3; % Any smaller and it doesn't converge fast enough
    
    %% Iteration
    index = 1; % Counter to store final solution
    p = 1;
    f = @(z, P, K)flash(z, P, T, k, ap, bp, K, plim);
    
    while p <= length(P)
        
        [x, y, alp, Kn, err] = f(z, P(p), Kg);

        % This block was commented out when testing for divergence at
        % P1(1) = 5e5 and 5.2e5
        if p == 1 % Adjust pressure only for first iteration, don't save any values
            while err == 1 % Bring pressure up until we reach the first pressure at which equilibria exists, otherwise estimation with zero order continuation won't work
                Kg = wilson(Pc, P(p), Tc, T, w);
                [x, y, alp, Kn, err] = f(z, P(p), Kg);
                
                if alp == 1
                    p = p + 1; % Vapour region, increase pressure
                elseif alp == 0 % If overshot to liquid region, increase feed fraction
                    z = [z(1) + dx, z(2) - dx];
                    z = z ./ (z * ones(N, 1)); % Normalize z
                end
            end
        end
        
        %% Zero order continuation
        
        if alp < 0.2 && err == 0 % Still in VLE region, but low vapour fraction, need to shift up feed
            z = [z(1) + dx, z(2) - dx];
            z = z ./ (z * ones(N, 1)); % Normalize z
        elseif err == 1
            if alp == 0 % All liquid, on liquid line
                z = [z(1) + dx, z(2) - dx]; % Increase system comp of 1, this was commented out when testing for divergence at P1(1) = 5.2e5
            elseif alp == 1
                z = [z(1) - dx, z(2) + dx]; % Decrease system comp of 1
            end
            
            if z(1) == 0
                z = [0.001 + dx, 0.999 - dx];
            end
            
            z = z ./ (z * ones(N, 1)); % Normalize z
        end
        
        xsol(index, :) = x;
        ysol(index, :) = y;
        psol(index) = P(p);
        
        p = p + 1;
        index = index + 1;
        Kg = Kn;
        
    end
    
    % Removing empty values
    
    xsol(index:end, :) = [];
    ysol(index:end, :) = [];
    psol(index:end, :) = [];
    
    if i == 1
        xsol1 = xsol;
        ysol1 = ysol;
        psol1 = psol;
    else
        xsol2 = xsol;
        ysol2 = ysol;
        psol2 = psol;
    end
    
end

figure(1)

grid on
grid minor

myTitle  =  {'Pressure-Equilibrium Composition of' 'Isobutane-Carbon Dioxide System' ''};
xlabel('Composition of Carbon Dioxide')
ylabel('Pressure (Pa)')
title(myTitle)

hold on

plot(xsol1(:, 1), psol1, 'Color', [0 0.4470 0.7410]);
plot(ysol1(:, 1), psol1, 'Color', [0.8500 0.3250 0.0980]);

plot(xsol2(:, 1), psol2);
plot(ysol2(:, 1), psol2);

hold off

legend('Liquid @ 310.928 K', 'Vapour @ 310.928 K', 'Liquid @ 377.594 K', 'Vapour @ 377.594 K', 'Location', 'northeastoutside')
legend('boxoff')

print(figure(1),'-dpng','-r600','equilibrium')
