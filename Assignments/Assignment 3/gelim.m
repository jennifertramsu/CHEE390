function [x, inv] = gelim(a)
% Checking dimensions

[m, n] = size(a);

if n ~= m+1 % Because last column is constant matrix
    error('Matrix is not square!')
end

% Appending identity matrix
id = eye(m);

a = [a id]; % matrix | constant matrix | identity matrix

%% Performing elimination

s = max(abs(a(:, 1:m)), [], 2); % Max value

for k = 1:m-1
    % Scaled Row Pivoting
    si = s(k);
    rmax = abs(a(k, k))/si;
    row = k;
    
    for j = k + 1:m
        r = abs(a(j, k))/si;
        if r > rmax
            rmax = r;
            row = j;
        end
    end
    
   % Swap rows
    a = swapr(a, k, row);
    s = swapr(s, k, row);
    
    for i = k + 1:m
        p = a(i, k) / a(k, k); % Multiplier
        a(i, :) = a(i, :) - a(k, :) * p;
    end
end

%% Separate vector b and the transformed identity matrix 
% Separate matrix a from vector b

b = a(:,n);
a(:,n) = []; % Erasing constant matrix, what's leftover is matrix and transformed identity

% Calculating inverse
inv = inverse(a);

a(:, m + 1:end) = []; % Retrieving REF

% RCON Check

rc = rcon(a, inv);

if rc < eps || abs(rc) == inf || isnan(rc) 
    warning('Matrix might be singular and results inaccurate. RCOND = %8.6e.',rc)
end

%% Back Substitution

x = zeros(m, 1);

x(m) = b(m) / a(m, m);

for j = m-1:-1:1
    x(j) = (b(j) - a(j, j + 1:m) * x(j + 1:m)) / a(j, j);
end

end
