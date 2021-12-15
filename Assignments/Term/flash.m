function [x, y, alp, K, err] = flash(z, P, T, k, ap, bp, K, plim)
% Flash calculation - determines the equilibrium composition at a specified
% pressure
% z = feed composition
% P = pressure
% T = temperature
% k = interaction parameters
% ap, bp = pure mixing coefficients
% K = guess equilibrium constant
% plim = pressure limit beyond which bisection is called
% x = equilibrium liquid composition
% y = equilibrium vapour composition
% alp = vapour fraction
% K = converged equilibrium constant
% err = flag for error

%% Initialization
R = 8.314; % m3 Pa K−1 mol−1
N = length(z);
kmax = 100;
counter = 1;
err = 0;

while counter <= kmax
    
    r = @(v) vapfrac(v, z, K); % Residual
    dr = @(v) dp(v, z, K); % Derivative of residual
    
    if sign(r(0)*r(1)) <= 0
        alp = newtonrm(r, dr, 0, 1e-12);
        nphase = 2;
    elseif r(0) <= 0
        alp = 0;
        nphase = 1;
    elseif r(1) >= 0
        alp = 1;
        nphase = 1;
    else
        error('Something went wrong.')
    end
    
    %% Solving for vapour and liquid compositions
    x = z ./ (1 + alp.*(K - 1));
    y = K .* x;
    
    % Normalizing x and y
    x = x ./ (x * ones(N, 1));
    y = y ./ (y * ones(N, 1));
    
    bv = (y.*bp) * ones(N, 1);
    bl = (x.*bp) * ones(N, 1);
    
    av = 0;
    al = 0;
    
    for i = 1:N
        for j = 1:N
            av = av + y(i)*y(j)*sqrt(ap(i)*ap(j))*(1 - k(i, j));
            al = al + x(i)*x(j)*sqrt(ap(i)*ap(j))*(1 - k(i, j));
        end
    end
    
    %% Solving for the compressibility factors of each phase
    Av = av*P / (R*T)^2;
    Bv = bv*P / (R*T);
    
    Al = al*P / (R*T)^2;
    Bl = bl*P / (R*T);
    
    if P < plim
        r1 = [1, -(1 - Bv), Av - 3*Bv^2 - 2*Bv, -(Av*Bv - Bv^2 - Bv^3)];
        Zv = roots(r1);
        
        r2 = [1, -(1 - Bl), Al - 3*Bl^2 - 2*Bl, -(Al*Bl - Bl^2 - Bl^3)];
        Zl = roots(r2);
        
        Zv = max(Zv);
        Zl = min(Zl);
        
        if ~isreal(Zv)
            r = @(Z) peng(Z, Av, Bv);
            Zv = bisection(r, 0, 1, 1e-12);
        elseif ~isreal (Zl)
            r = @(Z) peng(Z, Al, Bl);
            Zl = bisection(r, 0, 1, 1e-12);
        end
        
    else % Above a certain pressure, call bisection
        r = @(Z) peng(Z, Av, Bv);
        Zv = bisection(r, 0, 1, 1e-12);
        r = @(Z) peng(Z, Al, Bl);
        Zl = bisection(r, 0, 1, 1e-12);
    end
    
    %% Fugacities
    fv = fugacity(y, av, bv, ap, bp, Zv, Av, Bv, P, k);
    fl = fugacity(x, al, bl, ap, bp, Zl, Al, Bl, P, k);
    
    thetag = (y .* log(fv ./ fl)) * ones(N, 1);
    
    if abs(thetag) <= 1e-7
        break % Flash converged!
    else
        if counter == 1
            K = K .* (fl./fv);
        else
            if abs(thetag - thetap) <= 1e-8
                err = 1;
                
                if alp == 0 
                    fprintf('The system is in the liquid region.\n')
                elseif alp == 1
                    fprintf('The system is in the vapour region.\n')
                end
                
                break
            else
                K = K .* (fl./fv);
            end
        end
        
        if nphase ~= 2
            K = K .* exp(thetag); % Kick up if only one phase
        end
        
    end
    
    counter = counter + 1;
    thetap = thetag;
    
end