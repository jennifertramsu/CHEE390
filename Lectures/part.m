function v=part(v, left, right)

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
% write in recursion
end