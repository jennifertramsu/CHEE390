% NOTES
% implementing quicksort 
% (1) turn plane into 1D array
% (2) use quicksort to sort 1D array
% (3) turn 1D array back into plane
% nvm we want in-place sorting

function v=quicksort(v, left, right)
% Quicksort algorithm to sort a row vector in ascending order
% Chooses random pivot between left and right indices
% v = row vector
% left = left index
% right = right index

if right < left
    return
end

i = left;
j = right;
s = right - left + 1; % can't use length for subarrays
pivot = left + floor(s*rand(1)); % avoiding ^

piv = v(pivot);

while i <= j
    while v(i) < piv % on the left, find the first value that's larger than the pivot
        i = i + 1;
    end
    while v(j) > piv % on the right, find the first value that's smaller than the pivot
        j = j-1;
    end
    if i <= j
        % swap
        vtmp = v(j);
        v(j) = v(i);
        v(i) = vtmp;
        i = i+1;
        j = j-1;
    end
end

% recursion on left side
v = quicksort_double(v, left, j);

% recursion on right side
v = quicksort_double(v, i, right);
        
end