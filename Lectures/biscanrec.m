% Lecture 4 - Sept. 14, 2021

function [v mid] = biscanrec(z, p, left, right, tol)
% z = array to be scanned
% p = value to search for
% left = left index
% right = right index
% tol = relative tolerance condition
% Binary Search Method - Recursive

mid = ceil((right + left) / 2);

if p > z(mid) && abs(1 - z(mid)/p) > tol && left < right
    [v mid] = biscanrec(z, p, mid + 1, right, tol);
elseif p < z(mid) && abs(1 - z(mid)/p) > tol && left < right
    [v mid] = biscanrec(z, p, left, mid - 1, tol);
elseif abs(1 - z(mid)/p) < tol
    v = z(mid);
else
    error('No value found')
end

end