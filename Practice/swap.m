function a = swap(a, p, q, rc)
% Swap rows or columns
% rc should be set to r for row or c for column
% if rc is blank, assume rowswap

if nargin == 3
    rc = 'r';
end

% if rc is row, swap rows, otherwise swap columns

if rc == 'r'
    rswap = a(p, :);
    a(p, :) = a(q, :);
    a(q, :) = rswap;
else
    cswap = a(:, p);
    a(:, p) = a(:, q);
    a(:, q) = cswap;
end

end