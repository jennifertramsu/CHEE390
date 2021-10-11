function inv = inverse(a)

% Checking dimensions

mn=size(a);
m=mn(1);
n=mn(2);

if m ~= n
    error('a matrix is not square')
end

% Append identity matrix
id = eye(m);

a = [a id];

% Performing elimination

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

% Divide each row by the pivot value to obtain a leading one in each row

for i = 1:m
    a(i, :) = a(i, :) / a(i, i);
end

% Eliminate non-leading one values

for k = m:-1:1
    for j = k - 1:-1:1
        p = a(j, k) / a(k, k);
        a(j, :) = a(j, :) - a(k, :) * p;
    end
end

inv = a(:, m + 1:end);

end