function [x, y, alp, K, err] = flash(z, P, T, k, ap, bp, K)
% Flash calculation - determines the equilibrium composition at a specified
% pressure

%% Initialization
R = 8.314; % m3 Pa K−1 mol−1
N = length(z);
kmax = 100;
counter = 1;
err = 0;

while counter <= kmax
    
    r = @(v) vapfrac(v, z, K);
    
    if sign(r(0)*r(1)) <= 0
        alp = newtonrm(r, 0, 0, 1, 1e-12);
        nphase = 2;
    elseif r(0) <= 0
        alp = 0;
        nphase = 1;
    elseif r(1) >= 0
        alp = 1;
        nphase = 1;
    else
        err = 1;
        alp = NaN;
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
    
    %% Solving for molar volumes of each species --- need to check if roots are real
    Av = av*P / (R*T)^2;
    Bv = bv*P / (R*T);
    r1 = [1, -(1 - Bv), Av - 3*Bv^2 - 2*Bv, -(Av*Bv - Bv^2 - Bv^3)];
    Zv = roots(r1);
    
    Al = al*P / (R*T)^2;
    Bl = bl*P / (R*T);
    r2 = [1, -(1 - Bl), Al - 3*Bl^2 - 2*Bl, -(Al*Bl - Bl^2 - Bl^3)];
    Zl = roots(r2);
    
    Zv = max(Zv);
    Zl = min(Zl);
    
    %% Fugacities
    fv = fugacity(y, av, bv, ap, bp, Zv, Av, Bv, P, k);
    fl = fugacity(x, al, bl, ap, bp, Zl, Al, Bl, P, k);
    
    thetag = (y .* log(fv ./ fl)) * ones(N, 1);
    
    if abs(thetag) <= 1e-7
        break
    else
        if counter == 1
            K = K .* (fl./fv);
        else
            if abs(thetag - thetap) <= 1e-8
                err = 1;
                break
            else
                K = K .* (fl./fv);
            end
        end
        
        if nphase ~= 2
            K = K .* exp(thetag);
        end
        
    end
    counter = counter + 1;
    thetap = thetag;
 
end