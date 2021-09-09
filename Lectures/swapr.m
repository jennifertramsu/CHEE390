% Lecture 3 - Sept. 9, 2021

function a=swapr(a, p, q)
% a - matrix
% p, q - rows to swap

rswap = a(p, :);
a(p, :) = a(q, :);
a(q, :) = rswap;

end