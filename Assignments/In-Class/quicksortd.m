function v=quicksortd(v, left, right, col)
%% Recursive quicksort with double indexing that sorts a specific column
% v = matrix to be sorted
% left = left index
% right = right index
% col = column to sort

if right < left
    return
end

i = left;
j = right;
s = right - left + 1; % can't use length for subarrays
pivot = left + ceil(s*rand(1)) - 1; % must subtract one to avoid going out of bounds

piv = v(pivot, col);

while i <= j
    while v(i, col) < piv % on the left, find the first value that's larger than the pivot
        i = i + 1;
    end
    while v(j, col) > piv % on the right, find the first value that's smaller than the pivot
        j = j-1;
    end
    if i <= j
        % swap
        vtmp = v(j, :);
        v(j, :) = v(i, :);
        v(i, :) = vtmp;
        i = i+1;
        j = j-1;
    end
end

% recursion on left side
v = quicksortd(v, left, j, col);

% recursion on right side
v = quicksortd(v, i, right, col);
        
end