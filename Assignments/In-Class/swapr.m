function a = swapr(a, p, q)
% Swap rows
% a = matrix
% p = first row
% q = second row

rswap = a(p, :);
a(p, :) = a(q, :);
a(q, :) = rswap;

end