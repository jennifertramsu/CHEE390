function v=quicksort(v, left, right, matrix)
% Copyright (c) 2010 - Phillip Servio
% Recursive quicksort algorithm applied to an array v
% Random pivot selection, two-sided comparison
% v = array to be sorted
% left = left index
% right = right index

if right < left
    return
end

i = left;
j = right;
s = right - left + 1; % can't use length for subarrays
pivot = left + floor(s*rand(1)); 

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
        if matrix == 1
            vtmp = v(j);
            v(j) = v(i);
            v(i) = vtmp;
        else 
            vtmp = v(j, :);
            v(j, :) = v(i, :);
            v(i, :) = vtmp;
        end
        i = i+1;
        j = j-1;
    end
end

% recursion on left side
v = quicksort(v, left, j, matrix);

% recursion on right side
v = quicksort(v, i, right, matrix);
        
end