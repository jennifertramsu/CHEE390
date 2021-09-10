function v=part(v, left, right)

if right == left
    return
end

i = left;
pivot = right;
tmp = v(pivot);
% partitioning
while i < pivot
    while v(i) > tmp
        v(pivot) = v(i);
        v(i) = v(pivot-1);
        v(pivot-1) = tmp;
        pivot = pivot-1;
    end
    i = i+1;
end

% recursion for smaller array
v = part(v, left, pivot-1);

% recursion for larger array
v = part(v, pivot, right);

end