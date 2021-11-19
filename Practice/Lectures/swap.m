% Lecture 3 - Sept. 9, 2021

function a=swap(a, p, q, rc) % can't put default parameter in function name
% Swap rows or columns
% rc should be set to r for row or c for column
% if rc is blank, default to rowswap
% a - matrix
% p, q - rows/columns to swap

if nargin == 3
    rc = 'r';
end

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