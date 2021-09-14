% Lecture 4 - Sept. 14, 2021

function [v mid] = biscan(z, p, tol)
% z = array to be scanned
% p = value to search for
% tol = relative tolerance condition
% Binary Search Method - Iterative

right = length(z);
left = 1;
mid = ceil((right + left) / 2);
check = abs(1 - z(mid)/p);

while check >= tol && right > left
    if p > z(mid)
        left = mid + 1;
    else
        right = mid - 1;
    end

    mid = ceil((right + left) / 2); % finding new midpoint
    check = abs(1 - z(mid)/p); 
end

if check <= tol % on final midpoint, perhaps right > left, need to check if tolerance met
    v = z(mid);
else
    error('Value not found')
end

end