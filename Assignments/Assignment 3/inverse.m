function inv = inverse(ma)

[m, ~] = size(ma);

a = ma(:, :); % Making a copy

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