function v=part(v, left, right)
% v = array to be sorted
% left = left index, first index to be sorted
% right = right index, last index to be sorted
if right == left
    return
end

i = left;
pivot = right;
tmp = v(pivot);
% partitioning
while i < pivot
    while v(i) > tmp % comparing current value to value at pivot
        v(pivot) = v(i); % place value where pivot is
        v(i) = v(pivot-1); % changing value to be compared (value in front of pivot)
        v(pivot-1) = tmp; % moving value at pivot down by one
        pivot = pivot-1; % moving pivot down
    end
    i = i+1;
end

% recursion for smaller array
v = part(v, left, pivot-1);

% recursion for larger array
v = part(v, pivot, right);

end